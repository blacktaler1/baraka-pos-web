import 'package:baraka_pos/features/firma/domain/domain.dart';
import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

final class PayDebtRequest extends RemoteRequest<LoanFirmaPayload> {
  final int firmaId;
  final int debtId;
  final int amount;

  PayDebtRequest.fromPayload(super.payload)
      : firmaId = payload.firmaId,
        debtId = payload.debtId,
        amount = payload.amount,
        super.fromPayload();

  @override
  Json data() => {
        "amount": amount,
      };

  @override
  Map<String, String> path() => {
        "firma_id": firmaId.toString(),
        "pk": debtId.toString(),
      };

  @override
  Map<String, String> query() => {};
}
