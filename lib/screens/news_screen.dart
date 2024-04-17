import 'dart:convert';

import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class NewsArticle {
  String title;
  String link;
  String author;
  String videoUrl;
  String description;
  String content;
  DateTime publishedAt;
  String urlToImage;
  String source;
  String language;
  NewsArticle({
    required this.title,
    required this.author,
    required this.link,
    required this.videoUrl,
    required this.description,
    required this.content,
    required this.publishedAt,
    required this.urlToImage,
    required this.source,
    required this.language,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> j) {
    return NewsArticle(
      link: j['link'] ?? '',
      videoUrl: j['video_url'] ?? '',
      language: j['language'] ?? '',
      title: j['title'] ?? '',
      content: j['content'] ?? '',
      urlToImage: j['urlToImage'] ?? '',
      description: j['description'] ?? '',
      author: j['creator']?.first ?? '',
      source: j['source_id'] ?? '',
      publishedAt:
          j['pubDate'] != null ? DateTime.parse(j['pubDate']) : DateTime.now(),
    );
  }
}

class NewsScreen extends StatefulWidget {
  final String? title;
  const NewsScreen({super.key, this.title});

  @override
  // ignore: library_private_types_in_public_api
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<News>? selectedNewsList = newsList;
  List<NewsArticle> newsArticles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (selectedNewsList == null || selectedNewsList!.isEmpty)
              const Expanded(
                child: Center(
                  child: Text('No news selected'),
                ),
              )
            else
              Expanded(
                child: buildNewsArticles(),
              ),
          ],
        ),
      ),
    );
  }

  buildNewsArticles() {
    if (newsArticles.isNotEmpty) {
      return SizedBox(
        width: 1500,
        child: ListView.builder(itemBuilder: (BuildContext context, int idx) {
          final item = newsArticles[idx];

          return ListTile(
            contentPadding: const EdgeInsets.all(50),
            title: Text(item.title, style: const TextStyle(fontSize: 30)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    style: const TextStyle(fontSize: 15),
                    item.publishedAt.toLocal().toString()),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(
                        item.urlToImage,
                        height: 300,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const SizedBox(
                              height: 300,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              maxLines: 2,
                              item.description,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        }),
      );
    } else {
      return Container();
    }
  }

  // Future<List<NewsArticle>> fetchArticles() async {
  Future<List<NewsArticle>> fetchArticles() async {
    try {
      String url =
          "https://newsapi.org/v2/top-headlines?country=us&apiKey=$KNEWS";
      final response = await http.get(Uri.parse(url));
      if (false) {
        // Error();
        final Map<String, dynamic> data = json.decode(response.body);
        setArticles(data);
      } else {
        final localJson = await rootBundle.loadString("json/news.json");
        final Map<String, dynamic> data = json.decode(localJson);
        setArticles(data);
      }

      return [];
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchArticles();
      _openFilterDialog();
    });
  }

  Future<void> openFilterDelegate() async {
    await FilterListDelegate.show<News>(
      context: context,
      list: newsList,
      selectedListData: selectedNewsList,
      theme: FilterListDelegateThemeData(
        listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          tileColor: Colors.white,
          selectedColor: Colors.red,
          selectedTileColor: const Color(0xFF649BEC).withOpacity(.5),
          textColor: Colors.blue,
        ),
      ),
      // enableOnlySingleSelection: true,
      onItemSearch: (news, query) {
        return news.name!.toLowerCase().contains(query.toLowerCase());
      },
      tileLabel: (news) => news!.name,
      emptySearchChild: const Center(child: Text('No news found')),
      // enableOnlySingleSelection: true,
      searchFieldHint: 'Search Here..',
      /*suggestionBuilder: (context, news, isSelected) {
        return ListTile(
          title: Text(news.name!),
          leading: const CircleAvatar(
            backgroundColor: Colors.blue,
          ),
          selected: isSelected,
        );
      },*/
      onApplyButtonClick: (list) {
        setState(() {
          selectedNewsList = list;
        });
      },
    );
  }

  void setArticles(Map<String, dynamic> data) {
    final List<dynamic> articles = data['articles'];
    List<NewsArticle> res =
        articles.map((item) => NewsArticle.fromJson(item)).toList();
    res = res.where((element) => element.urlToImage != '').toList();
    setState(() {
      newsArticles = res;
    });
  }

  Future<void> _openFilterDialog() async {
    await FilterListDialog.display<News>(
      context,
      height: 500,
      listData: newsList,
      headlineText: 'Select Topics',
      hideSelectedTextCount: true,
      selectedListData: selectedNewsList,
      choiceChipLabel: (item) => item!.name,
      themeData: FilterListThemeData(context),
      validateSelectedItem: (list, val) => list!.contains(val),
      controlButtons: [ControlButtonType.All, ControlButtonType.Reset],
      onItemSearch: (news, query) {
        return news.name!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedNewsList = List.from(list!);
        });
        Navigator.pop(context);
      },
      choiceChipBuilder: (context, item, isSelected) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              border: Border.all(
            color: isSelected! ? Colors.blue[300]! : Colors.grey[300]!,
          )),
          child: Text(
            item.name,
            style: TextStyle(
                color: isSelected ? Colors.blue[300] : Colors.grey[500]),
          ),
        );
      },
    );
  }
}
