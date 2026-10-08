import 'package:baraka_pos/features/cash/cash.dart';

import '../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../../shared/aplication/utils/safed.dart';

abstract class CashRepository {
  Future<Safed<BaseException, AllCashProductModel>> getAllCashProduct({
    required CashProductPayload payload,
  });

  Future<Safed<BaseException, TransactionModel>> createTransaction({
    required CreateTransactionPayload payload,
  });

  Future<Safed<BaseException, AllTransactionModel>> getAllTransaction({
    required GetTransactionPayload payload,
  });

  Future<Safed<BaseException, RefoundModel>> refoundTransaction({
    required RefoundTransactionPayload payload,
  });

  Future<Safed<BaseException, AllRefundsModel>> getAllRefunds({
    required GetRefundPayload payload,
  });

  Future<Safed<BaseException, DailyChecksModel>> getDailyCheks({
    required DailyChecksPayload payload,
  });
}
