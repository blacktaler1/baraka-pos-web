import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../../features/auth/data/table/auth_table.dart';
import '../../../features/auth/data/table/user_table.dart';
import '../../../features/cash/data/table/pending_transactions.dart';
import '../../../features/cash/data/table/product_table.dart';
import '../../../features/global/data/table/category_table.dart';
import '../../../features/settings/data/table/printer_settings_table.dart';

part 'local_sources.g.dart';

@DriftDatabase(
  tables: [
    UserTable,
    AuthTable,
    ProductTable,
    CategoryTable,
    PendingTransactions,
    PrinterSettingsTable,
  ],
)
class PosLocalDatabase extends _$PosLocalDatabase {
  PosLocalDatabase._internal() : super(_openConnection());
  static final PosLocalDatabase instance = PosLocalDatabase._internal();

  @override
  int get schemaVersion => 9;
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(userTable, userTable.warehouseId);
            await m.addColumn(userTable, userTable.warehouseUuid);
            await m.addColumn(userTable, userTable.warehouseShopName);
            await m.addColumn(userTable, userTable.warehouseAddress);
            await m.addColumn(userTable, userTable.warehouseContact);
            await m.addColumn(userTable, userTable.warehousePhrase);
            await m.addColumn(userTable, userTable.warehouseOwner);
          }

          if (from < 3) {
            await m.createTable(pendingTransactions);
          }

          if (from < 5) {
            await m.addColumn(
              printerSettingsTable,
              printerSettingsTable.barcodePrinterName,
            );
          }

          if (from < 7) {
            final columns = await customSelect(
              "PRAGMA table_info(product_table)",
            ).get();

            final exists = columns.any((c) => c.data['name'] == 'pack_size');

            if (!exists) {
              await m.addColumn(productTable, productTable.packSize);
            }
          }

          if (from < 9) {
            await m.addColumn(productTable, productTable.meterPrice);
          }

          if (from < 8) {
            await m.addColumn(userTable, userTable.canDiscount);
            await m.addColumn(userTable, userTable.maxDiscountPercent);
            await m.addColumn(userTable, userTable.canEditPrice);
            await m.addColumn(userTable, userTable.canRefund);
            await m.addColumn(productTable, productTable.wholesalePrice);
          }
        },
      );
}

// Web: brauzerdagi sqlite (OPFS / IndexedDB) — web/sqlite3.wasm va web/drift_worker.js kerak
QueryExecutor _openConnection() {
  return driftDatabase(
    name: 'baraka_pos_local',
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
    ),
  );
}
