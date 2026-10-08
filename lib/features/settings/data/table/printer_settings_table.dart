import 'package:drift/drift.dart';

class PrinterSettingsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get printerName => text().nullable()();
  TextColumn get barcodePrinterName => text().nullable()();
}
