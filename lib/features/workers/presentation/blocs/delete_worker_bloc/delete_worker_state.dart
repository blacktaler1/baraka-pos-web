part of 'delete_worker_bloc.dart';

sealed class DeleteWorkerState extends Equatable {
  const DeleteWorkerState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(NoContentModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      DeleteWorkerInitial() => initial(),
      DeleteWorkerPrepare() => inPrepare(),
      DeleteWorkerSuccess(:final model) => success(model),
      DeleteWorkerFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(NoContentModel model)? success,
    T Function(BaseException error)? failure,
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
    T Function(NoContentModel model)? success,
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

final class DeleteWorkerInitial extends DeleteWorkerState {}

final class DeleteWorkerPrepare extends DeleteWorkerState {}

final class DeleteWorkerSuccess extends DeleteWorkerState {
  final NoContentModel model;

  const DeleteWorkerSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class DeleteWorkerFailure extends DeleteWorkerState {
  final BaseException error;

  const DeleteWorkerFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
