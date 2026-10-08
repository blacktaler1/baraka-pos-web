import 'package:drift/drift.dart';

class PendingTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get payload => text()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
