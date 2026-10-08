part of 'refound_transaction_bloc.dart';

sealed class RefoundTransactionEvent extends Equatable {
  const RefoundTransactionEvent();

  @override
  List<Object> get props => [];
}

final class RefoundTransactionStarted extends RefoundTransactionEvent {
  final int transactionId;
  final String description;
  final CreateItemCollection items;

  const RefoundTransactionStarted({
    required this.transactionId,
    required this.description,
    required this.items,
  });

  @override
  List<Object> get props => [
        "pk: $transactionId",
        "description: $description",
        "items: $items",
      ];
}
