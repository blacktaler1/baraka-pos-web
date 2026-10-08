part of 'remove_inventory_item_bloc.dart';

sealed class RemoveInventoryItemState extends Equatable {
  const RemoveInventoryItemState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(InventoryCountModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      RemoveInventoryItemInitial() => initial(),
      RemoveInventoryItemPrepare() => inPrepare(),
      RemoveInventoryItemSuccess(:final model) => success(model),
      RemoveInventoryItemFailure(:final error) => failure(error),
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

final class RemoveInventoryItemInitial extends RemoveInventoryItemState {}

final class RemoveInventoryItemPrepare extends RemoveInventoryItemState {}

final class RemoveInventoryItemSuccess extends RemoveInventoryItemState {
  final InventoryCountModel model;

  const RemoveInventoryItemSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class RemoveInventoryItemFailure extends RemoveInventoryItemState {
  final BaseException error;

  const RemoveInventoryItemFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
