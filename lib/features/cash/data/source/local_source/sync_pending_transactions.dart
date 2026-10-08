import 'dart:convert';

import 'package:baraka_pos/features/cash/data/source/local_source/transaction_local_source.dart';

import '../../../../../shared/aplication/configs/di/injection_container.dart';
import '../../../domain/payload/create_transaction_payload.dart';
import '../../request/create_transaction_request.dart';
import '../remote_source/cash_remote_source.dart';
import 'connectivity_service.dart';

Future<void> syncPendingTransactions() async {
  final connectivity = sl<ConnectivityService>();
  if (!await connectivity.hasInternet()) return;

  final pendingLocal = sl<PendingTransactionLocalSource>();
  final remote = sl<CashRemoteSource>();

  final list = await pendingLocal.getAll();

  for (final tx in list) {
    try {
      final payload = CreateTransactionPayload.fromJson(
        jsonDecode(tx.payload),
      );

      final result = await remote.createTransaction(
        request: CreateTransactionRequest.fromPayload(payload),
      );

      await result.when(
        success: (dto) async {
          await pendingLocal.delete(tx.id);
        },
        failure: (_) async {},
      );
    } catch (_) {
      continue;
    }
  }
}
