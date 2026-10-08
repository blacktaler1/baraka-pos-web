import 'package:baraka_pos/shared/domain/domain.dart';

final class LoanFirmaPayload extends Payload {
  final int firmaId;
  final int debtId;
  final int amount;

  const LoanFirmaPayload({
    required this.firmaId,
    required this.debtId,
    required this.amount,
  });

  @override
  List<Object> get props => [
        "id:$firmaId",
        "pk: $debtId",
        "amount: $amount",
      ];
}
