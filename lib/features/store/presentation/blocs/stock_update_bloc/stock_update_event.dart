part of 'stock_update_bloc.dart';

sealed class StockUpdateEvent extends Equatable {
  const StockUpdateEvent();

  @override
  List<Object> get props => [];
}

final class StockUpdateEventStarted extends StockUpdateEvent {
  final String action;
  final String purchase;
  final bool returnToFirma;
  final double amount;
  final int pk;

  const StockUpdateEventStarted({
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
