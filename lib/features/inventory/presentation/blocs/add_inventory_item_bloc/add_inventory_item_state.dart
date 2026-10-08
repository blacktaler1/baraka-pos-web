part of 'add_inventory_item_bloc.dart';

sealed class AddInventoryItemState extends Equatable {
  const AddInventoryItemState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(InventoryCountModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      AddInventoryItemInitial() => initial(),
      AddInventoryItemPrepare() => inPrepare(),
      AddInventoryItemSuccess(:final model) => success(model),
      AddInventoryItemFailure(:final error) => failure(error),
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

final class AddInventoryItemInitial extends AddInventoryItemState {}

final class AddInventoryItemPrepare extends AddInventoryItemState {}

final class AddInventoryItemSuccess extends AddInventoryItemState {
  final InventoryCountModel model;

  const AddInventoryItemSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class AddInventoryItemFailure extends AddInventoryItemState {
  final BaseException error;

  const AddInventoryItemFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
