import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  const Comment({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitleTextStyle: const TextStyle(height: 3),
      title: const Row(
        children: [
          Icon(Icons.circle, size: 50),
          Text('Username'),
          Spacer(),
          Text('Hours ago...')
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          const Text('body'),
          const SizedBox(height: 5),
          Row(
            children: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_upward)),
              TextButton(
                child: const Text('10'),
                onPressed: () {},
              ),
              // icon: const Icon(Icons.abc)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_downward)),
              TextButton.icon(
                label: const Text('Show Replies'),
                onPressed: () {},
                icon: const Icon(Icons.comment),
              ),
              TextButton.icon(
                label: const Text('Reply'),
                onPressed: () {},
                icon: const Icon(Icons.reply),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Solution extends StatelessWidget {
  const Solution({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitleTextStyle: const TextStyle(height: 3),
      title: const Row(
        children: [
          Icon(Icons.circle),
          Text('Username'),
          Spacer(),
          Text('DateTime')
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    TextButton(
                      style: const ButtonStyle(
                          visualDensity: VisualDensity.compact),
                      onPressed: () {},
                      child: Text('Tag $index',
                          style: const TextStyle(fontSize: 12)),
                    ),
                  ],
                );
              },
            ),
          ),
          const Text('sososo'),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                label: Text('10'),
                onPressed: () {},
                icon: Icon(Icons.arrow_upward),
              ),
              TextButton.icon(
                label: Text('4.5K'),
                onPressed: () {},
                icon: Icon(Icons.remove_red_eye_outlined),
              ),
              TextButton.icon(
                label: Text('5'),
                onPressed: () {},
                icon: Icon(Icons.comment),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Submission extends StatefulWidget {
  const Submission({super.key});

  @override
  State<Submission> createState() => _SubmissionState();
}

class SubmissionTable extends StatelessWidget {
  const SubmissionTable({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a list of rows to display in the table
    final rows = [
      // Sample data for the table
      const DataRow(
        cells: [
          DataCell(Text('Active')),
          DataCell(Text('Dart')),
          DataCell(Text('Flutter')),
          DataCell(Text('32 MB')),
          DataCell(Text('This is a note')),
        ],
      ),
      const DataRow(
        cells: [
          DataCell(Text('Inactive')),
          DataCell(Text('Java')),
          DataCell(Text('Spring')),
          DataCell(Text('64 MB')),
          DataCell(Text('This is another note')),
        ],
      ),
      // Add more rows as needed
    ];

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: DataTable(
          columns: const [
            // Define the headers for each column
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Language')),
            DataColumn(label: Text('Runtime')),
            DataColumn(label: Text('Memory')),
            DataColumn(label: Text('Notes')),
          ],
          rows: rows,
        ),
      ),
    );
  }
}

class _SubmissionState extends State<Submission> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitleTextStyle: const TextStyle(height: 20),
      title: const Row(
        children: [
          Icon(Icons.circle),
          Text('Username'),
          Spacer(),
          Text('DateTime')
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          SizedBox(
            height: 500,
            width: double.infinity,
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    TextButton(
                      style: const ButtonStyle(
                          visualDensity: VisualDensity.compact),
                      onPressed: () {},
                      child: Text('Tag $index',
                          style: const TextStyle(fontSize: 8)),
                    ),
                    const Text('sososo')
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 5),
          Container(
            // color: Colors.red,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.abc),
                Text('# Votes'),
                Icon(Icons.remove_red_eye_outlined),
                Text('# Views'),
                Icon(Icons.comment),
                Text('# Comments'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
