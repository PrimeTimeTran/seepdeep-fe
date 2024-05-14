// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:app/all.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class News {
  String link;
  String title;
  String author;
  String source;
  String content;
  String videoUrl;
  String language;
  String urlToImage;
  String description;
  DateTime publishedAt;
  News({
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

  factory News.fromJson(Map<String, dynamic> j) {
    return News(
      link: j['link'] ?? '',
      title: j['title'] ?? '',
      content: j['content'] ?? '',
      source: j['source_id'] ?? '',
      language: j['language'] ?? '',
      videoUrl: j['video_url'] ?? '',
      urlToImage: j['urlToImage'] ?? '',
      author: j['creator']?.first ?? '',
      description: j['description'] ?? '',
      publishedAt:
          j['pubDate'] != null ? DateTime.parse(j['pubDate']) : DateTime.now(),
    );
  }
}

class NewsScreen extends StatefulWidget {
  final String? title;
  const NewsScreen({super.key, this.title});

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<NewsTopic>? selectedNewsTopics = newsTopics;
  List<News> articles = [];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: getWidth() / 1.4,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 100,
                width: double.infinity,
                child: FilterListWidget(
                  listData: selectedNewsTopics,
                  hideHeader: true,
                  hideSelectedTextCount: true,
                  selectedListData: selectedNewsTopics,
                  choiceChipLabel: (item) => item!.name,
                  themeData: FilterListThemeData(context),
                  validateSelectedItem: (list, val) => list!.contains(val),
                  controlButtons: const [
                    ControlButtonType.All,
                    ControlButtonType.Reset,
                  ],
                  onItemSearch: (topic, query) {
                    return topic.name!
                        .toLowerCase()
                        .contains(query.toLowerCase());
                  },
                  onApplyButtonClick: (list) {
                    setState(() {
                      selectedNewsTopics = List.from(list!);
                    });
                  },
                  choiceChipBuilder: (context, item, isSelected) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected!
                                ? Colors.blue[300]!
                                : Colors.grey[300]!,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30))),
                      child: Text(
                        item.name,
                        style: TextStyle(
                            color: isSelected
                                ? Colors.blue[300]
                                : Colors.grey[500]),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                child: buildArticles(),
                width: getWidth() / 3,
                height: getHeight(),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildArticles() {
    if (articles.isNotEmpty) {
      return ListView.builder(
          // physics: NeverScrollableScrollPhysics(),
          // clipBehavior: Clip.antiAlias,
          itemBuilder: (BuildContext context, int idx) {
        final item = articles[idx];
        return ListTile(
          contentPadding: const EdgeInsets.all(50),
          title: Text(
            item.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
      });
    } else {
      return Container();
    }
  }

  // Future<List<Article>> fetchArticles() async {
  Future<List<News>> fetchArticles() async {
    try {
      String url =
          "https://newsapi.org/v2/top-headlines?country=us&apiKey=$KNEWS";
      final response = await http.get(Uri.parse(url));
      if (!kDebugMode) {
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
      final localJson = await rootBundle.loadString("json/news.json");
      final Map<String, dynamic> data = json.decode(localJson);
      setArticles(data);
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchArticles();
      // _openFilterDialog();
    });
  }

  Future<void> openFilterDelegate() async {
    await FilterListDelegate.show<NewsTopic>(
      context: context,
      list: newsTopics,
      selectedListData: selectedNewsTopics,
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
          selectedNewsTopics = list;
        });
      },
    );
  }

  void setArticles(Map<String, dynamic> data) {
    final List<dynamic> fetchedArticles = data['articles'];
    List<News> res =
        fetchedArticles.map((item) => News.fromJson(item)).toList();
    res = res.where((element) => element.urlToImage != '').toList();
    setState(() {
      articles = res;
    });
  }

  Future<void> _openFilterDialog() async {
    await FilterListDialog.display<NewsTopic>(
      context,
      height: 500,
      listData: newsTopics,
      headlineText: 'Select Topics',
      hideSelectedTextCount: true,
      selectedListData: selectedNewsTopics,
      choiceChipLabel: (item) => item!.name,
      themeData: FilterListThemeData(context),
      validateSelectedItem: (list, val) => list!.contains(val),
      controlButtons: [ControlButtonType.All, ControlButtonType.Reset],
      onItemSearch: (news, query) {
        return news.name!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedNewsTopics = List.from(list!);
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
