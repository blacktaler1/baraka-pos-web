import 'package:drift/drift.dart';

import '../../../../../shared/data/sources/local_sources.dart';

class PendingTransactionLocalSource {
  final PosLocalDatabase db;

  PendingTransactionLocalSource(this.db);

  Future<void> insert(String payload) {
    return db.into(db.pendingTransactions).insert(
          PendingTransactionsCompanion(
            payload: Value(payload),
          ),
        );
  }

  Future<List<PendingTransaction>> getAll() {
    return db.select(db.pendingTransactions).get();
  }

  Future<void> delete(int id) {
    return (db.delete(db.pendingTransactions)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}
