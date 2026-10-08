import 'package:baraka_pos/shared/domain/domain.dart';

final class StockUpdatePayload extends Payload {
  final String action;
  final double amount;
  final int pk;

  const StockUpdatePayload({
    required this.action,
    required this.amount,
    required this.pk,
  });

  @override
  List<Object> get props => [
        "action: $action",
        "amount: $amount",
        "pk: $pk",
      ];
}
