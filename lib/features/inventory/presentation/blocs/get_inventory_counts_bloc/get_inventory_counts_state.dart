part of 'get_inventory_counts_bloc.dart';

sealed class GetInventoryCountsState extends Equatable {
  const GetInventoryCountsState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(GetInventoryCountsModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      GetInventoryCountsInitial() => initial(),
      GetInventoryCountsPrepare() => inPrepare(),
      GetInventoryCountsSuccess(:final model) => success(model),
      GetInventoryCountsFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(GetInventoryCountsModel model)? success,
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
    T Function(GetInventoryCountsModel model)? success,
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

final class GetInventoryCountsInitial extends GetInventoryCountsState {}

final class GetInventoryCountsPrepare extends GetInventoryCountsState {}

final class GetInventoryCountsSuccess extends GetInventoryCountsState {
  final GetInventoryCountsModel model;

  const GetInventoryCountsSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class GetInventoryCountsFailure extends GetInventoryCountsState {
  final BaseException error;

  const GetInventoryCountsFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
