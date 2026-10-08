part of 'current_shift_bloc.dart';

sealed class CurrentShiftEvent extends Equatable {
  const CurrentShiftEvent();

  @override
  List<Object> get props => [];
}

final class CurrentShiftStarted extends CurrentShiftEvent {
  const CurrentShiftStarted();
}
