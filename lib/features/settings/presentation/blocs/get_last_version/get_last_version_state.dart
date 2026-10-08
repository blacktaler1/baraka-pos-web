part of 'get_last_version_bloc.dart';

sealed class GetLastVersionState extends Equatable {
  const GetLastVersionState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(LastVersionModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      GetLastVersionInitial() => initial(),
      GetLastVersionPrepare() => inPrepare(),
      GetLastVersionSuccess(:final model) => success(model),
      GetLastVersionFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(LastVersionModel model)? success,
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
    T Function(LastVersionModel model)? success,
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

final class GetLastVersionInitial extends GetLastVersionState {}

final class GetLastVersionPrepare extends GetLastVersionState {}

final class GetLastVersionFailure extends GetLastVersionState {
  final BaseException error;

  const GetLastVersionFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}

final class GetLastVersionSuccess extends GetLastVersionState {
  final LastVersionModel model;

  const GetLastVersionSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}
