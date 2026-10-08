part of 'open_shift_bloc.dart';

sealed class OpenShiftEvent extends Equatable {
  const OpenShiftEvent();

  @override
  List<Object> get props => [];
}

final class OpenShiftStarted extends OpenShiftEvent {
  final int openingCash;

  const OpenShiftStarted({
    required this.openingCash,
  });

  @override
  List<Object> get props => [
        "openingCash: $openingCash",
      ];
}
