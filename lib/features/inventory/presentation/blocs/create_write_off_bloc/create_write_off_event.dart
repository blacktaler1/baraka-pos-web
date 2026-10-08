part of 'create_write_off_bloc.dart';

sealed class CreateWriteOffEvent extends Equatable {
  const CreateWriteOffEvent();

  @override
  List<Object> get props => [];
}

final class CreateWriteOffStarted extends CreateWriteOffEvent {
  final String reason;
  final String note;
  final List<StockLineInput> items;

  const CreateWriteOffStarted({
    required this.reason,
    required this.note,
    required this.items,
  });

  @override
  List<Object> get props => [
        "reason: $reason",
        "note: $note",
        "items: $items",
      ];
}
