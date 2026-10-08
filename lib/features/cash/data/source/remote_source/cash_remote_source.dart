import 'package:baraka_pos/features/auth/auth.dart';
import 'package:baraka_pos/features/cash/cash.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../../../shared/aplication/utils/safed.dart';

final class CashRemoteSource extends RemoteSource {
  CashRemoteSource({required super.client});

  Future<Safed<BaseException, AllCashProductDto>> getCashProduct({
    required CashProductRequest request,
  }) async {
    return await apiGet(
            path: "/${globalUser?.warehouseUuid}/product/", request: request)
        .map(
      success: dataFactory(AllCashProductDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, TransactionDto>> createTransaction({
    required CreateTransactionRequest request,
  }) async {
    return await apiPost(
            path: "/${globalUser?.warehouseUuid}/transaction/",
            request: request)
        .map(
      success: dataFactory(TransactionDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, AllTransactionDto>> getAllTransaction({
    required GetTransactionRequest request,
  }) async {
    return await apiGet(
            path: "/${globalUser?.warehouseUuid}/transaction/",
            request: request)
        .map(
      success: dataFactory(AllTransactionDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, RefoundDto>> refundTransaction({
    required RefundTransactionRequest request,
  }) async {
    return await apiPost(
            path:
                "/${globalUser?.warehouseUuid}/transaction/${request.transactionId}/refund/",
            request: request)
        .map(
      success: dataFactory(RefoundDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, AllRefundsDto>> getAllRefunds({
    required GetRefundRequest request,
  }) async {
    return await apiGet(
            path: "/${globalUser?.warehouseUuid}/transaction/refunds/",
            request: request)
        .map(
      success: dataFactory(AllRefundsDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, DailyChecksDto>> getDailyChekcs({
    required DailyChecksRequest request,
  }) async {
    return await apiGet(
            path: "/${globalUser?.warehouseUuid}/transaction/daily-checks/",
            request: request)
        .map(
      success: dataFactory(DailyChecksDto.fromJson),
      failure: (BaseException e) => e,
    );
  }
}
