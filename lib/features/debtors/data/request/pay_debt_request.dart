import 'package:baraka_pos/features/debtors/domain/payload/pay_debt_payload.dart';
import 'package:baraka_pos/shared/shared.dart';

final class PayDebtRequest extends RemoteRequest<PayDebtPayload> {
  final int id;
  final num amount;
  PayDebtRequest.fromPayload(super.payload)
      : id = payload.debtId,
        amount = payload.amount,
        super.fromPayload();

  @override
  Json data() => {
        "debt_record_id": id,
        "amount": amount,
      };

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
