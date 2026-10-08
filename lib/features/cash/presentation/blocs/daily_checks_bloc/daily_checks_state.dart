part of 'daily_checks_bloc.dart';

sealed class DailyChecksState extends Equatable {
  const DailyChecksState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(DailyChecksModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      DailyChecksInitial() => initial(),
      DailyChecksPrepare() => inPrepare(),
      DailyChecksSuccess(:final model) => success(model),
      DailyChecksFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(DailyChecksModel model)? success,
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
    T Function()? idle,
    T Function()? inPrepare,
    T Function(DailyChecksModel model)? success,
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

final class DailyChecksInitial extends DailyChecksState {}

final class DailyChecksPrepare extends DailyChecksState {}

final class DailyChecksSuccess extends DailyChecksState {
  final DailyChecksModel model;

  const DailyChecksSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class DailyChecksFailure extends DailyChecksState {
  final BaseException error;

  const DailyChecksFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
