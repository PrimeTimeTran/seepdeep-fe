import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

const go = """
# SQL Lesson 1: SELECT queries 101

To retrieve data from a SQL database, we write SELECT statements, which are often referred to as **queries**.

A query in itself is a statement which declares what data we're looking for, where to find it in the database, and optionally, how to transform it before it is returned.

It has a specific syntax though, which is what we are going to learn in the following exercises.

It's helpful to think of a table in SQL as a specific type of entity. Each row is an instance of that entity. The columns would then represent properties of an entity.

For example on the right we have the table `Movies`. Each movie has the same properties, `title`, `director`, `year` etc, but their properties have different values, `Toy Story`, `A Bug's Life`, etc.

The syntax for selecting data from our table follows:

```sql
SELECT column, another_column, ...
FROM my_table;
```

So if we wanted to select the title of all our movies in our database we would write

```sql
SELECT title
FROM movies;
```
""";

class LessonMarkDown extends StatelessWidget {
  const LessonMarkDown({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight() / 2,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<String>(
          future: loadMarkdownContent(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                  child: Text('Error loading Markdown content.'));
            } else {
              return Markdown(
                data: go ?? '',
                onTapLink: (text, url, title) {
                  launchUrl(Uri.parse(url!));
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<String> loadMarkdownContent() async {
    try {
      final data =
          await rootBundle.loadString('assets/lessons/sql/1-select.md');
      return data;
    } catch (e) {
      print("Error loading Markdown content: $e");
      return '';
    }
  }
}
