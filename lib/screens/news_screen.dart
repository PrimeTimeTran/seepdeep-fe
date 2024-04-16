import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';

/// Creating a global list for example purpose.
/// Generally it should be within data class or where ever you want
List<User> userList = [
  User(name: "Python", avatar: "user.png"),
  User(name: "Dart", avatar: "user.png"),
  User(name: "SQL", avatar: "user.png"),
  User(name: "Postgres", avatar: "user.png"),
  User(name: "MongoDB", avatar: "user.png"),
  User(name: "C", avatar: "user.png"),
  User(name: "C++", avatar: "user.png"),
  User(name: "C#", avatar: "user.png"),
  User(name: "Go", avatar: "user.png"),
  User(name: "Mojo", avatar: "user.png"),
  User(name: "Ruby", avatar: "user.png"),
  User(name: "Typescript", avatar: "user.png"),
  User(name: "Javascript", avatar: "user.png"),
  User(name: "Flutter", avatar: "user.png"),
  User(name: "Vue", avatar: "user.png"),
  User(name: "React", avatar: "user.png"),
  User(name: "React Native", avatar: "user.png"),
  User(name: "Nuxt", avatar: "user.png"),
  User(name: "Next", avatar: "user.png"),
  User(name: "Ruby on Rails", avatar: "user.png"),
  User(name: "Django", avatar: "user.png"),
  User(name: ".Net", avatar: "user.png"),
  User(name: "NodeJS", avatar: "user.png"),
  User(name: "Flask", avatar: "user.png"),
  User(name: "Kubernetes", avatar: "user.png"),
  User(name: "Docker", avatar: "user.png"),
  User(name: "Data Analysis", avatar: "user.png"),
  User(name: "Data Analytics", avatar: "user.png"),
  User(name: "LLM", avatar: "user.png"),
  User(name: "AI", avatar: "user.png"),
  User(name: "Machine Learning", avatar: "user.png"),
  User(name: "Theresa", avatar: "user.png"),
  User(name: "Una", avatar: "user.png"),
  User(name: "Vanessa", avatar: "user.png"),
  User(name: "Victoria", avatar: "user.png"),
  User(name: "Wanda", avatar: "user.png"),
  User(name: "Wendy", avatar: "user.png"),
  User(name: "Yvonne", avatar: "user.png"),
  User(name: "Zoe", avatar: "user.png"),
];

class FilterPage extends StatelessWidget {
  final List<User>? allTextList;
  List<User>? selectedUserList = userList;
  FilterPage({super.key, this.allTextList, this.selectedUserList});
  @override
  Widget build(BuildContext context) {
    return FilterListWidget<User>(
      themeData: FilterListThemeData(context),
      hideSelectedTextCount: true,
      listData: userList,
      selectedListData: selectedUserList,
      onApplyButtonClick: (list) {
        Navigator.pop(context, list);
      },
      choiceChipLabel: (item) {
        /// Used to print text on chip
        return item!.name;
      },
      // choiceChipBuilder: (context, item, isSelected) {
      //   return Container(
      //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      //     margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      //     decoration: BoxDecoration(
      //         border: Border.all(
      //       color: isSelected! ? Colors.blue[300]! : Colors.grey[300]!,
      //     )),
      //     child: Text(item.name),
      //   );
      // },
      validateSelectedItem: (list, val) {
        ///  identify if item is selected or not
        return list!.contains(val);
      },
      onItemSearch: (user, query) {
        /// When search query change in search bar then this method will be called
        ///
        /// Check if items contains query
        return user.name!.toLowerCase().contains(query.toLowerCase());
      },
    );
  }
}

class NewsScreen extends StatefulWidget {
  final String? title;
  const NewsScreen({super.key, this.title});

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class User {
  final String? name;
  final String? avatar;
  User({this.name, this.avatar});
}

class _NewsScreenState extends State<NewsScreen> {
  List<User>? selectedUserList = userList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          if (selectedUserList == null || selectedUserList!.isEmpty)
            const Expanded(
              child: Center(
                child: Text('No user selected'),
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(selectedUserList![index].name!),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: selectedUserList!.length,
              ),
            ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton(
              onPressed: () async {
                final list = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilterPage(
                      allTextList: userList,
                      selectedUserList: selectedUserList,
                    ),
                  ),
                );
                if (list != null) {
                  setState(() {
                    selectedUserList = List.from(list);
                  });
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: const Text(
                "Filter Page",
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: _openFilterDialog,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: const Text(
                "Filter Dialog",
                style: TextStyle(color: Colors.white),
              ),
              // color: Colors.blue,
            ),
            TextButton(
              onPressed: openFilterDelegate,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: const Text(
                "Filter Delegate",
                style: TextStyle(color: Colors.white),
              ),
              // color: Colors.blue,
            ),
          ],
        ),
      ),
      body: const Text('soso'),
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
    await FilterListDelegate.show<User>(
      context: context,
      list: userList,
      selectedListData: selectedUserList,
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
      onItemSearch: (user, query) {
        return user.name!.toLowerCase().contains(query.toLowerCase());
      },
      tileLabel: (user) => user!.name,
      emptySearchChild: const Center(child: Text('No user found')),
      // enableOnlySingleSelection: true,
      searchFieldHint: 'Search Here..',
      /*suggestionBuilder: (context, user, isSelected) {
        return ListTile(
          title: Text(user.name!),
          leading: const CircleAvatar(
            backgroundColor: Colors.blue,
          ),
          selected: isSelected,
        );
      },*/
      onApplyButtonClick: (list) {
        setState(() {
          selectedUserList = list;
        });
      },
    );
  }

  Future<void> _openFilterDialog() async {
    await FilterListDialog.display<User>(
      context,
      height: 500,
      listData: userList,
      headlineText: 'Select Topics',
      hideSelectedTextCount: true,
      selectedListData: selectedUserList,
      choiceChipLabel: (item) => item!.name,
      themeData: FilterListThemeData(context),
      validateSelectedItem: (list, val) => list!.contains(val),
      controlButtons: [ControlButtonType.All, ControlButtonType.Reset],
      onItemSearch: (user, query) {
        /// When search query change in search bar then this method will be called
        ///
        /// Check if items contains query
        return user.name!.toLowerCase().contains(query.toLowerCase());
      },

      onApplyButtonClick: (list) {
        setState(() {
          selectedUserList = List.from(list!);
        });
        Navigator.pop(context);
      },

      /// uncomment below code to create custom choice chip
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
/// Another example of [FilterListWidget] to filter list of strings
/*
 FilterListWidget<String>(
    listData: [
      "One",
      "Two",
      "Three",
      "Four",
      "five",
      "Six",
      "Seven",
      "Eight",
      "Nine",
      "Ten"
    ],
    selectedListData: ["One", "Three", "Four", "Eight", "Nine"],
    onApplyButtonClick: (list) {
      Navigator.pop(context, list);
    },
    choiceChipLabel: (item) {
      /// Used to print text on chip
      return item;
    },
    validateSelectedItem: (list, val) {
      ///  identify if item is selected or not
      return list!.contains(val);
    },
    onItemSearch: (text, query) {
      return text.toLowerCase().contains(query.toLowerCase());
    },
  )
*/