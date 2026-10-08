import 'package:drift/drift.dart';

class CategoryTable extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  TextColumn get image => text()();
  @override
  Set<Column> get primaryKey => {id};
}
