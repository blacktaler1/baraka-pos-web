part of 'close_shift_bloc.dart';

sealed class CloseShiftEvent extends Equatable {
  const CloseShiftEvent();

  @override
  List<Object> get props => [];
}

final class CloseShiftStarted extends CloseShiftEvent {
  final int id;
  final int closingCash;
  final String note;

  const CloseShiftStarted({
    required this.id,
    required this.closingCash,
    required this.note,
  });

  @override
  List<Object> get props => [
        "id: $id",
        "closingCash: $closingCash",
        "note: $note",
      ];
}
