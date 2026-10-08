part of 'by_customer_history_bloc.dart';

sealed class ByCustomerHistoryState extends Equatable {
  const ByCustomerHistoryState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(AllCustomerHistoryModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      ByCustomerHistoryInitial() => initial(),
      ByCustomerHistoryPrepare() => inPrepare(),
      ByCustomerHistorySuccess(:final model) => success(model),
      ByCustomerHistoryFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(AllCustomerHistoryModel model)? success,
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
    T Function(AllCustomerHistoryModel model)? success,
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

final class ByCustomerHistoryInitial extends ByCustomerHistoryState {}

final class ByCustomerHistoryPrepare extends ByCustomerHistoryState {}

final class ByCustomerHistorySuccess extends ByCustomerHistoryState {
  final AllCustomerHistoryModel model;

  const ByCustomerHistorySuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class ByCustomerHistoryFailure extends ByCustomerHistoryState {
  final BaseException error;

  const ByCustomerHistoryFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
