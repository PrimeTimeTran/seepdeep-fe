import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class NewsScreen extends StatefulWidget {
  final String? title;
  const NewsScreen({super.key, this.title});

  @override
  // ignore: library_private_types_in_public_api
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<News>? selectedNewsList = newsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          if (selectedNewsList == null || selectedNewsList!.isEmpty)
            const Expanded(
              child: Center(
                child: Text('No news selected'),
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(selectedNewsList![index].name!),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: selectedNewsList!.length,
              ),
            ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
