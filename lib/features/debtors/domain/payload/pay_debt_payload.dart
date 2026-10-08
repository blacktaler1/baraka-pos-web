import '../../../../shared/shared.dart';

final class PayDebtPayload extends Payload {
  final int debtId;
  final num amount;

  const PayDebtPayload({
    required this.debtId,
    required this.amount,
  });

  @override
  List<Object> get props => [
        "debtId: $debtId",
        "amount: $amount",
      ];
}
