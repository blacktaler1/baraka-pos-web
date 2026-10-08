part of 'get_customer_bloc.dart';

sealed class GetCustomerState extends Equatable {
  const GetCustomerState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(GetCustomerModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      GetCustomerInitial() => initial(),
      GetCustomerPrepare() => inPrepare(),
      GetCustomerSuccess(:final model) => success(model),
      GetCustomerFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(GetCustomerModel model)? success,
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
    T Function(GetCustomerModel model)? success,
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

final class GetCustomerInitial extends GetCustomerState {}

final class GetCustomerPrepare extends GetCustomerState {}

final class GetCustomerSuccess extends GetCustomerState {
  final GetCustomerModel model;

  const GetCustomerSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class GetCustomerFailure extends GetCustomerState {
  final BaseException error;

  const GetCustomerFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
