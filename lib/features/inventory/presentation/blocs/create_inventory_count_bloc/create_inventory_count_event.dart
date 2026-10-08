part of 'create_inventory_count_bloc.dart';

sealed class CreateInventoryCountEvent extends Equatable {
  const CreateInventoryCountEvent();

  @override
  List<Object> get props => [];
}

final class CreateInventoryCountStarted extends CreateInventoryCountEvent {
  final String note;

  const CreateInventoryCountStarted({
    required this.note,
  });

  @override
  List<Object> get props => [
        "note: $note",
      ];
}
