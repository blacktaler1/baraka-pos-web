part of 'stock_update_bloc.dart';

sealed class StockUpdateEvent extends Equatable {
  const StockUpdateEvent();

  @override
  List<Object> get props => [];
}

final class StockUpdateEventStarted extends StockUpdateEvent {
  final String action;
  final double amount;
  final int pk;

  const StockUpdateEventStarted({
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
