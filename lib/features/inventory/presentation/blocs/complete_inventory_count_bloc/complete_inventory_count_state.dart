part of 'complete_inventory_count_bloc.dart';

sealed class CompleteInventoryCountState extends Equatable {
  const CompleteInventoryCountState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(InventoryCountModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      CompleteInventoryCountInitial() => initial(),
      CompleteInventoryCountPrepare() => inPrepare(),
      CompleteInventoryCountSuccess(:final model) => success(model),
      CompleteInventoryCountFailure(:final error) => failure(error),
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

final class CompleteInventoryCountInitial extends CompleteInventoryCountState {}

final class CompleteInventoryCountPrepare extends CompleteInventoryCountState {}

final class CompleteInventoryCountSuccess extends CompleteInventoryCountState {
  final InventoryCountModel model;

  const CompleteInventoryCountSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class CompleteInventoryCountFailure extends CompleteInventoryCountState {
  final BaseException error;

  const CompleteInventoryCountFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
