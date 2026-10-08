part of 'get_inventory_count_bloc.dart';

sealed class GetInventoryCountState extends Equatable {
  const GetInventoryCountState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(InventoryCountModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      GetInventoryCountInitial() => initial(),
      GetInventoryCountPrepare() => inPrepare(),
      GetInventoryCountSuccess(:final model) => success(model),
      GetInventoryCountFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(InventoryCountModel model)? success,
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
    T Function(InventoryCountModel model)? success,
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

final class GetInventoryCountInitial extends GetInventoryCountState {}

final class GetInventoryCountPrepare extends GetInventoryCountState {}

final class GetInventoryCountSuccess extends GetInventoryCountState {
  final InventoryCountModel model;

  const GetInventoryCountSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class GetInventoryCountFailure extends GetInventoryCountState {
  final BaseException error;

  const GetInventoryCountFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
