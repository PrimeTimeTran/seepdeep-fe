Migration steps

- Update tables
  ````dart
  @DataClassName('Customer')
  class Customers extends Table with AutoIncrementingPrimaryKey {
      TextColumn get country => text()();
  }```
  ````
- Bump version
  ```dart
    @override
    int get schemaVersion => 4;
  ```
- Generate schema dump
  `dart run drift_dev schema dump lib/database/database.dart drift_schemas/`
- Migrate DB
  `dart run drift_dev migrate`
- Generate schema steps
  `dart run drift_dev schema steps drift_schemas/ lib/database/schema_versions.dart`

SELECT year,
title,
oscars_won,
oscars_nominated
FROM films
ORDER BY oscars_nominated, oscars_won DESC limit 25;
