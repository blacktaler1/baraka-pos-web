part of 'refresh_bloc.dart';

sealed class RefreshState extends Equatable {
  const RefreshState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(LoginModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      RefreshInitial() => initial(),
      RefreshPrepare() => inPrepare(),
      RefreshSuccess(:final model) => success(model),
      RefreshFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(LoginModel model)? success,
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
    T Function(LoginModel model)? success,
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

final class RefreshInitial extends RefreshState {}

final class RefreshPrepare extends RefreshState {}

final class RefreshSuccess extends RefreshState {
  final LoginModel model;

  const RefreshSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class RefreshFailure extends RefreshState {
  final BaseException error;

  const RefreshFailure({
    required this.error,
  });

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
