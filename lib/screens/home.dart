import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database.dart';
import 'home/state.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.send),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: _addTodoEntry,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addTodoEntry() async {
    // We write the entry here. Notice how we don't have to call setState()
    // or anything - drift will take care of updating the list automatically.
    final database = ref.read(AppDatabase.provider);
    final currentCategory = ref.read(activeCategory);

    List<QueryRow> result = await database.customSelect(
      'SELECT * FROM employees',
      readsFrom: {...database.allTables},
    ).get();

    print(result.length);
    print(result[0].data);

    result = await database.customSelect(
      'SELECT * FROM playlists',
      readsFrom: {...database.allTables},
    ).get();

    print(result.length);
    print(result[0].data);
    result = await database.customSelect(
      'SELECT trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice FROM tracks;',
      readsFrom: {...database.allTables},
    ).get();

    print(result.length);
    print(result[0].data);

    database.todoEntries.insertOne(TodoEntriesCompanion.insert(
      description: _controller.text,
      category: Value(currentCategory?.id),
    ));

    _controller.clear();
  }
}
