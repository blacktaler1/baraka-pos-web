part of 'get_worker_list_bloc.dart';

sealed class GetWorkerListState extends Equatable {
  const GetWorkerListState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(GetWorkersListModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      GetWorkerListInitial() => initial(),
      GetWorkerListPrepare() => inPrepare(),
      GetWorkerListSuccess(:final model) => success(model),
      GetWorkerListFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(GetWorkersListModel model)? success,
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
    T Function(GetWorkersListModel model)? success,
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

final class GetWorkerListInitial extends GetWorkerListState {}

final class GetWorkerListPrepare extends GetWorkerListState {}

final class GetWorkerListSuccess extends GetWorkerListState {
  final GetWorkersListModel model;

  const GetWorkerListSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class GetWorkerListFailure extends GetWorkerListState {
  final BaseException error;

  const GetWorkerListFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
