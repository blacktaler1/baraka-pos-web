part of 'create_receipt_bloc.dart';

sealed class CreateReceiptState extends Equatable {
  const CreateReceiptState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(ReceiptModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      CreateReceiptInitial() => initial(),
      CreateReceiptPrepare() => inPrepare(),
      CreateReceiptSuccess(:final model) => success(model),
      CreateReceiptFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(ReceiptModel model)? success,
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
    T Function(ReceiptModel model)? success,
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

final class CreateReceiptInitial extends CreateReceiptState {}

final class CreateReceiptPrepare extends CreateReceiptState {}

final class CreateReceiptSuccess extends CreateReceiptState {
  final ReceiptModel model;

  const CreateReceiptSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class CreateReceiptFailure extends CreateReceiptState {
  final BaseException error;

  const CreateReceiptFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
