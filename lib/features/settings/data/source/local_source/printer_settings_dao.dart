import 'package:drift/drift.dart';

import '../../../../../shared/data/sources/local_sources.dart';

class PrinterSettingsDao {
  final PosLocalDatabase db;
  PrinterSettingsDao(this.db);

  /// CHECK PRINTER saqlash
  Future<void> saveCheckPrinter(String name) async {
    final old = await db.select(db.printerSettingsTable).getSingleOrNull();

    if (old == null) {
      await db.into(db.printerSettingsTable).insert(
            PrinterSettingsTableCompanion(
              printerName: Value(name),
            ),
          );
    } else {
      await db.update(db.printerSettingsTable).write(
            PrinterSettingsTableCompanion(
              printerName: Value(name),
            ),
          );
    }
  }

  /// BARCODE PRINTER saqlash
  Future<void> saveBarcodePrinter(String name) async {
    final old = await db.select(db.printerSettingsTable).getSingleOrNull();

    if (old == null) {
      await db.into(db.printerSettingsTable).insert(
            PrinterSettingsTableCompanion(
              barcodePrinterName: Value(name),
            ),
          );
    } else {
      await db.update(db.printerSettingsTable).write(
            PrinterSettingsTableCompanion(
              barcodePrinterName: Value(name),
            ),
          );
    }
  }

  /// CHECK PRINTER olish
  Future<String?> getPrinter() async {
    final res = await db.select(db.printerSettingsTable).getSingleOrNull();
    return res?.printerName;
  }

  /// BARCODE PRINTER olish
  Future<String?> getBarcodePrinter() async {
    final res = await db.select(db.printerSettingsTable).getSingleOrNull();
    return res?.barcodePrinterName;
  }
}
