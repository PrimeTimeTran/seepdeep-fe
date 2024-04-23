// ignore_for_file: must_be_immutable

import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownEditor extends StatefulWidget {
  String body;
  MarkdownEditor({super.key, required this.body});

  @override
  State<MarkdownEditor> createState() => _MarkdownEditorState();
}

class _MarkdownEditorState extends State<MarkdownEditor> {
  String text = '';
  final TextEditingController _controller = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      animationDuration: Duration.zero,
      child: Scaffold(
        appBar: buildToolbar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            double parentHeight = constraints.maxHeight - 50;
            return TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                buildEditor(parentHeight),
                buildPreviewer(parentHeight),
              ],
            );
          }),
        ),
      ),
    );
  }

  ScrollConfiguration buildEditor(height) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height,
                width: double.infinity,
                child: TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  controller: _controller,
                  maxLines: 100,
                  minLines: 30,
                  onChanged: (String val) {
                    setState(
                      () {
                        text = val;
                      },
                    );
                  },
                ),
              ),
              TextButton(onPressed: () {}, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }

  buildPreviewer(height) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height,
                width: double.infinity,
                child: Markdown(
                    key: const Key("defaultmarkdownformatter"),
                    data: text,
                    selectable: true,
                    padding: const EdgeInsets.all(10),
                    builders: {
                      'code': CodeElementBuilder(),
                    }),
              ),
              TextButton(onPressed: () {}, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildToolbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: TabBar(
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            tabs: [
              Row(
                children: [
                  const Tab(
                    icon: Icon(Icons.edit),
                  ),
                  Text(
                    'Editor',
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              Row(
                children: [
                  const Tab(
                    icon: Icon(Icons.preview_outlined),
                  ),
                  Text(
                    'Preview',
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    text = widget.body;
    _controller.text = text;
    setState(() {
      text = text;
    });
  }
}
