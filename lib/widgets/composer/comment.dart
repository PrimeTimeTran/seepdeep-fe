// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CommentRow extends StatelessWidget {
  const CommentRow({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitleTextStyle: const TextStyle(height: 3),
      title: const Row(
        children: [
          Icon(Icons.circle, size: 40),
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
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_upward,
                    size: 10,
                  ),
                  iconSize: 10,
                ),
                TextButton(
                  child: const Text('10'),
                  onPressed: () {},
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 10,
                ),
                TextButton.icon(
                  label: const Text('Show Replies'),
                  onPressed: () {},
                  icon: const Icon(Icons.comment, size: 10),
                ),
                TextButton.icon(
                  label: const Text('Reply'),
                  onPressed: () {},
                  icon: const Icon(Icons.reply, size: 10),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
