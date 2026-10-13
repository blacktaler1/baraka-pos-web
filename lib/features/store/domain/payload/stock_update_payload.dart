import 'package:baraka_pos/shared/domain/domain.dart';

final class StockUpdatePayload extends Payload {
  final String action;
  final String purchase;
  final bool returnToFirma;
  final double amount;
  final int pk;

  const StockUpdatePayload({
    required this.action,
    this.purchase = "",
    this.returnToFirma = false,
    required this.amount,
    required this.pk,
  });

  @override
  List<Object> get props => [
        "action: $action",
        "purchase: $purchase",
        "return_to_firma: $returnToFirma",
        "amount: $amount",
        "pk: $pk",
      ];
}
