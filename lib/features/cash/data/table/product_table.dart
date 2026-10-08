import 'package:drift/drift.dart';

class ProductTable extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  TextColumn get cost => text()();
  TextColumn get price => text()();
  TextColumn get wholesalePrice => text().withDefault(const Constant(''))();
  TextColumn get stock => text()();
  TextColumn get categoryTitle => text()();
  TextColumn get unit => text()();
  IntColumn get packSize => integer().nullable()();
  TextColumn get qrcode => text()();
  IntColumn get warehouse => integer()();
  TextColumn get images => text()(); // JSON string

  @override
  Set<Column> get primaryKey => {id};
}
