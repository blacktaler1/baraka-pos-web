part of 'cancel_inventory_count_bloc.dart';

sealed class CancelInventoryCountState extends Equatable {
  const CancelInventoryCountState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(InventoryCountModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      CancelInventoryCountInitial() => initial(),
      CancelInventoryCountPrepare() => inPrepare(),
      CancelInventoryCountSuccess(:final model) => success(model),
      CancelInventoryCountFailure(:final error) => failure(error),
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

final class CancelInventoryCountInitial extends CancelInventoryCountState {}

final class CancelInventoryCountPrepare extends CancelInventoryCountState {}

final class CancelInventoryCountSuccess extends CancelInventoryCountState {
  final InventoryCountModel model;

  const CancelInventoryCountSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class CancelInventoryCountFailure extends CancelInventoryCountState {
  final BaseException error;

  const CancelInventoryCountFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
