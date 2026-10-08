part of 'close_shift_bloc.dart';

sealed class CloseShiftState extends Equatable {
  const CloseShiftState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(CashShiftModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      CloseShiftInitial() => initial(),
      CloseShiftPrepare() => inPrepare(),
      CloseShiftSuccess(:final model) => success(model),
      CloseShiftFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(CashShiftModel model)? success,
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
    T Function(CashShiftModel model)? success,
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

final class CloseShiftInitial extends CloseShiftState {}

final class CloseShiftPrepare extends CloseShiftState {}

final class CloseShiftSuccess extends CloseShiftState {
  final CashShiftModel model;

  const CloseShiftSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class CloseShiftFailure extends CloseShiftState {
  final BaseException error;

  const CloseShiftFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
