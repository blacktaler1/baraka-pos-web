import 'package:baraka_pos/shared/domain/domain.dart';

final class PayCustomerDebtsPayload extends Payload {
  final int customerId;
  final String amount;

  const PayCustomerDebtsPayload({
    required this.customerId,
    required this.amount,
  });

  @override
  List<String> get props => [
        "customerId: $customerId",
        "amount: $amount",
      ];
}
