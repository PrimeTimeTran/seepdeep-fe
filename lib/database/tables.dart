import 'dart:ui';

import 'package:drift/drift.dart';

export 'dart:ui' show Color;

// Tables can mix-in common definitions if needed
mixin AutoIncrementingPrimaryKey on Table {
  IntColumn get id => integer().autoIncrement()();
}

@DataClassName('Category')
class Categories extends Table with AutoIncrementingPrimaryKey {
  // We can use type converters to store custom classes in tables.
  // Here, we're storing colors as integers.
  IntColumn get color => integer().map(const ColorConverter())();

  TextColumn get name => text()();
}

class ColorConverter extends TypeConverter<Color, int> {
  const ColorConverter();

  @override
  Color fromSql(int fromDb) => Color(fromDb);

  @override
  int toSql(Color value) => value.value;
}

@DataClassName('Customer')
class Customers extends Table with AutoIncrementingPrimaryKey {
  TextColumn get country => text()();
}

@DataClassName('TodoEntry')
class TodoEntries extends Table with AutoIncrementingPrimaryKey {
  // Todo entries can optionally be in a category.
  IntColumn get category => integer().nullable().references(Categories, #id)();

  TextColumn get description => text()();

  // Assume that this column didn't exist in the first version of the app, it
  // was added later.
  // After adding it, the `schemaVersion` in the database class was incremented
  // to 2 and a migration was written.
  //
  // With drift, database migrations can be unit-tested. See the readme of this
  // example for details.
  DateTimeColumn get dueDate => dateTime().nullable()();
}
