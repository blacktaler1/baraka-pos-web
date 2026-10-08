part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(LoginModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      LoginInitial() => initial(),
      LoginPrepare() => inPrepare(),
      LoginSuccess(:final model) => success(model),
      LoginFailure(:final error) => failure(error),
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

final class LoginInitial extends LoginState {}

final class LoginPrepare extends LoginState {}

final class LoginSuccess extends LoginState {
  final LoginModel model;

  const LoginSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class LoginFailure extends LoginState {
  final BaseException error;

  const LoginFailure({
    required this.error,
  });

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
