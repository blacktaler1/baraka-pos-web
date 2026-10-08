part of 'open_shift_bloc.dart';

sealed class OpenShiftState extends Equatable {
  const OpenShiftState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(CashShiftModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      OpenShiftInitial() => initial(),
      OpenShiftPrepare() => inPrepare(),
      OpenShiftSuccess(:final model) => success(model),
      OpenShiftFailure(:final error) => failure(error),
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

final class OpenShiftInitial extends OpenShiftState {}

final class OpenShiftPrepare extends OpenShiftState {}

final class OpenShiftSuccess extends OpenShiftState {
  final CashShiftModel model;

  const OpenShiftSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class OpenShiftFailure extends OpenShiftState {
  final BaseException error;

  const OpenShiftFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
