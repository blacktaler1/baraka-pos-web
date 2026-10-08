part of 'transaction_bloc.dart';

sealed class TransactionState extends Equatable {
  const TransactionState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(AllTransactionModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      TransactionInitial() => initial(),
      TransactionPrepare() => inPrepare(),
      TransactionSuccess(:final model) => success(model),
      TransactionFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(AllTransactionModel model)? success,
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
    T Function(AllTransactionModel model)? success,
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

final class TransactionInitial extends TransactionState {}

final class TransactionPrepare extends TransactionState {}

final class TransactionSuccess extends TransactionState {
  final AllTransactionModel model;

  const TransactionSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class TransactionFailure extends TransactionState {
  final BaseException error;

  const TransactionFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
