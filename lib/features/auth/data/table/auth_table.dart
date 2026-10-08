import 'package:drift/drift.dart';

class AuthTable extends Table {
  TextColumn get accessToken => text()();
  TextColumn get refreshToken => text()();
  IntColumn get userId =>
      integer().customConstraint('NOT NULL REFERENCES UserTable(id)')();
}
