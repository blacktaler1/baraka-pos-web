part of 'complete_inventory_count_bloc.dart';

sealed class CompleteInventoryCountEvent extends Equatable {
  const CompleteInventoryCountEvent();

  @override
  List<Object> get props => [];
}

final class CompleteInventoryCountStarted extends CompleteInventoryCountEvent {
  final int id;

  const CompleteInventoryCountStarted({
    required this.id,
  });

  @override
  List<Object> get props => [
        "id: $id",
      ];
}
