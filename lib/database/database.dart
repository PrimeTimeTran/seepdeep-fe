import 'package:drift/drift.dart';
import 'package:riverpod/riverpod.dart';

import 'connection/connection.dart' as impl;
// import 'schema_versions.dart';
import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Customers])
class AppDatabase extends _$AppDatabase {
  static final StateProvider<AppDatabase> provider = StateProvider((ref) {
    final database = AppDatabase();
    ref.onDispose(database.close);
    return database;
  });

  AppDatabase() : super(impl.connect());

  AppDatabase.forTesting(DatabaseConnection super.connection);

  // @override
  // MigrationStrategy get migration {
  //   return MigrationStrategy(
  //     onUpgrade: stepByStep(
  //       from1To2: (m, schema) async {
  //         await m.addColumn(schema.todoEntries, schema.todoEntries.dueDate);
  //       },
  //       from2To3: (m, schema) async {
  //         await m.create(schema.todosDelete);
  //         await m.create(schema.todosUpdate);
  //         await m.alterTable(TableMigration(schema.todoEntries));
  //       },
  //       from3To4: (m, schema) async {
  //         await m.create(schema.customers);
  //       },
  //     ),
  //     beforeOpen: (details) async {
  //       // Make sure that foreign keys are enabled
  //       await customStatement('PRAGMA foreign_keys = ON');

  //       if (details.wasCreated) {
  //         // Create a bunch of default values so the app doesn't look too empty
  //         // on the first start.
  //         await batch((b) {
  //           b.insert(
  //             categories,
  //             CategoriesCompanion.insert(name: 'Important', color: Colors.red),
  //           );

  //           b.insertAll(todoEntries, [
  //             TodoEntriesCompanion.insert(description: 'Check out drift'),
  //             TodoEntriesCompanion.insert(
  //                 description: 'Fix session invalidation bug',
  //                 category: const Value(1)),
  //             TodoEntriesCompanion.insert(
  //                 description: 'Add favorite movies to home page'),
  //           ]);
  //         });
  //       }

  //       // This follows the recommendation to validate that the database schema
  //       // matches what drift expects (https://drift.simonbinder.eu/docs/advanced-features/migrations/#verifying-a-database-schema-at-runtime).
  //       // It allows catching bugs in the migration logic early.
  //       await impl.validateDatabaseSchema(this);
  //     },
  //   );
  // }

  @override
  int get schemaVersion => 4;
}
