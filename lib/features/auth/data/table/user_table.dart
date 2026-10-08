import 'package:drift/drift.dart';

class UserTable extends Table {
  /// Backend user id
  IntColumn get id => integer()();

  TextColumn get name => text().nullable()(); // nullable

  TextColumn get role => text().withDefault(const Constant(''))();

  TextColumn get code => text().withDefault(const Constant(''))();

  TextColumn get phone => text().withDefault(const Constant(''))();

  TextColumn get limit => text().withDefault(const Constant(''))();

  TextColumn get dateJoined => text().withDefault(const Constant(''))();

  BoolColumn get limitExceeded =>
      boolean().withDefault(const Constant(false))();

  TextColumn get image => text().withDefault(const Constant(''))();

  /// 🔽 WAREHOUSE
  IntColumn get warehouseId => integer().nullable()();

  TextColumn get warehouseUuid => text().withDefault(const Constant(''))();

  TextColumn get warehouseShopName => text().withDefault(const Constant(''))();

  TextColumn get warehouseAddress => text().withDefault(const Constant(''))();

  TextColumn get warehouseContact => text().withDefault(const Constant(''))();

  TextColumn get warehousePhrase => text().withDefault(const Constant(''))();

  IntColumn get warehouseOwner => integer().withDefault(const Constant(0))();

  BoolColumn get canDiscount => boolean().withDefault(const Constant(false))();

  RealColumn get maxDiscountPercent => real().withDefault(const Constant(0))();

  BoolColumn get canEditPrice => boolean().withDefault(const Constant(true))();

  BoolColumn get canRefund => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}
