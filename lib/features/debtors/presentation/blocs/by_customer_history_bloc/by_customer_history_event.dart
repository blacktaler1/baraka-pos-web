part of 'by_customer_history_bloc.dart';

sealed class ByCustomerHistoryEvent extends Equatable {
  const ByCustomerHistoryEvent();
}

final class ByCustomerHistoryStarted extends ByCustomerHistoryEvent {
  final int id;
  final bool history;

  const ByCustomerHistoryStarted({
    required this.id,
    required this.history,
  });

  @override
  List<Object> get props => [
        "id: $id",
        "history: $history",
      ];
}
