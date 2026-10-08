part of 'update_worker_bloc.dart';

sealed class UpdateUserState extends Equatable {
  const UpdateUserState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(UserModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      UpdateUserInitial() => initial(),
      UpdateUserPrepare() => inPrepare(),
      UpdateUserSuccess(:final model) => success(model),
      UpdateUserFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(UserModel model)? success,
    T Function(BaseException error)? failure,
    required T Function() orElse,
  }) {
    return when(
      initial: initial ?? orElse,
      inPrepare: inPrepare ?? orElse,
      success: success ?? (_) => orElse(),
      failure: failure ?? (_) => orElse(),
    );
  }

  T? whenOrNull<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(UserModel model)? success,
    T Function(BaseException error)? failure,
  }) {
    return maybeWhen(
      initial: initial,
      inPrepare: inPrepare,
      success: success,
      failure: failure,
      orElse: () => null,
    );
  }

  @override
  List<Object> get props => [];
}

final class UpdateUserInitial extends UpdateUserState {}

final class UpdateUserPrepare extends UpdateUserState {}

final class UpdateUserSuccess extends UpdateUserState {
  final UserModel model;

  const UpdateUserSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class UpdateUserFailure extends UpdateUserState {
  final BaseException error;

  const UpdateUserFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
