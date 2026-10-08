part of 'current_shift_bloc.dart';

sealed class CurrentShiftState extends Equatable {
  const CurrentShiftState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(CurrentShiftModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      CurrentShiftInitial() => initial(),
      CurrentShiftPrepare() => inPrepare(),
      CurrentShiftSuccess(:final model) => success(model),
      CurrentShiftFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(CurrentShiftModel model)? success,
    T Function(BaseException)? failure,
    required T Function() orElse,
  }) {
    return when(
      initial: initial ?? orElse,
      inPrepare: inPrepare ?? orElse,
      failure: failure ?? (_) => orElse(),
      success: success ?? (_) => orElse(),
    );
  }

  T? whenOrNull<T>({
    T Function()? inPrepare,
    T Function(CurrentShiftModel model)? success,
    T Function(BaseException error)? failure,
  }) {
    return maybeWhen(
      inPrepare: inPrepare,
      failure: failure,
      success: success,
      orElse: () => null,
    );
  }

  @override
  List<Object> get props => [];
}

final class CurrentShiftInitial extends CurrentShiftState {}

final class CurrentShiftPrepare extends CurrentShiftState {}

final class CurrentShiftSuccess extends CurrentShiftState {
  final CurrentShiftModel model;

  const CurrentShiftSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class CurrentShiftFailure extends CurrentShiftState {
  final BaseException error;

  const CurrentShiftFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
