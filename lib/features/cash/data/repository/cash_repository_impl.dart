import 'dart:convert';

import 'package:baraka_pos/features/cash/cash.dart';
import 'package:baraka_pos/shared/aplication/exceptions/base_exception.dart';
import 'package:baraka_pos/shared/aplication/utils/safed.dart';

import '../../../../shared/aplication/configs/di/injection_container.dart';
import '../source/local_source/connectivity_service.dart';

final class CashRepositoryImpl extends CashRepository {
  final CashRemoteSource remote;

  final local = sl<CashProductLocalSource>();

  CashRepositoryImpl({
    required this.remote,
  });

  @override
  Future<Safed<BaseException, AllCashProductModel>> getAllCashProduct({
    required CashProductPayload payload,
  }) async {
    try {
      final result = await remote.getCashProduct(
        request: CashProductRequest.fromPayload(payload),
      );
      return await result.when(
        success: (dto) async {
          final model = dto.model();
          await local.syncProducts(model.data.models);
          return Success(model);
        },
        failure: (e) async {
          final localData = await local.getAllProducts(
            search: payload.search,
            category: payload.category,
          );
          return Success(
            AllCashProductModel(
              next: "",
              previous: "",
              total: 0,
              data: CashProductCollection(models: localData),
            ),
          );
        },
      );
    } catch (_) {
      final localProducts = await local.getAllProducts(
        search: payload.search,
        category: payload.category,
      );

      return Success<BaseException, AllCashProductModel>(
        AllCashProductModel(
          next: "",
          previous: "",
          total: localProducts.length,
          data: CashProductCollection(models: localProducts),
        ),
      );
    }
  }

  final connectivity = sl<ConnectivityService>();

  @override
  Future<Safed<BaseException, TransactionModel>> createTransaction({
    required CreateTransactionPayload payload,
  }) async {
    final connectivity = sl<ConnectivityService>();
    final isOnline = await connectivity.hasInternet();

    if (isOnline) {
      final request = CreateTransactionRequest.fromPayload(payload);
      final result = await remote.createTransaction(request: request);

      return result.map(
        success: (dto) => dto.model(),
        failure: (e) => e,
      );
    }

    //  OFFLINE → PAYLOAD JSON SAQLAYMIZ
    await sl<PendingTransactionLocalSource>().insert(
      jsonEncode(payload.toJson()),
    );

    //  FAKE SUCCESS (UI uchun)
    return Success(
      TransactionModel(
        id: -1,
        transactionId: 'offline',
        paymentMethod: payload.paymentMethod,
        totalSum: '0',
        totalQuantity: '0',
        profit: '0',
        items: TransactionItemCollection(models: []),
        created: DateTime.now().toIso8601String(),
        modified: DateTime.now().toIso8601String(),
        cashier: CashierModel(
          id: 0,
          name: '',
        ),
      ),
    );
  }

  @override
  Future<Safed<BaseException, AllTransactionModel>> getAllTransaction(
      {required GetTransactionPayload payload}) async {
    final result = await remote.getAllTransaction(
        request: GetTransactionRequest.fromPayload(payload));
    return result.map(
      success: (dto) => dto.model(),
      failure: (e) => e,
    );
  }

  @override
  Future<Safed<BaseException, RefoundModel>> refoundTransaction({
    required RefoundTransactionPayload payload,
  }) async {
    final result = await remote.refundTransaction(
        request: RefundTransactionRequest.fromPayload(payload));
    return result.map(
      success: (dto) => dto.model(),
      failure: (e) => e,
    );
  }

  @override
  Future<Safed<BaseException, AllRefundsModel>> getAllRefunds({
    required GetRefundPayload payload,
  }) async {
    final result = await remote.getAllRefunds(
        request: GetRefundRequest.fromPayload(payload));
    return result.map(
      success: (dto) => dto.model(),
      failure: (e) => e,
    );
  }

  @override
  Future<Safed<BaseException, DailyChecksModel>> getDailyCheks({
    required DailyChecksPayload payload,
  }) async {
    return await remote
        .getDailyChekcs(
          request: DailyChecksRequest.fromPayload(payload),
        )
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }
}
