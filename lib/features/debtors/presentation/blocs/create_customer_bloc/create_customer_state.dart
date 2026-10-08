part of 'create_customer_bloc.dart';

sealed class CreateCustomerState extends Equatable {
  const CreateCustomerState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(CustomerModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      CreateCustomerInitial() => initial(),
      CreateCustomerPrepare() => inPrepare(),
      CreateCustomerSuccess(:final model) => success(model),
      CreateCustomerFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(CustomerModel model)? success,
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
    T Function(CustomerModel model)? success,
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

final class CreateCustomerInitial extends CreateCustomerState {}

final class CreateCustomerPrepare extends CreateCustomerState {}

final class CreateCustomerSuccess extends CreateCustomerState {
  final CustomerModel model;

  const CreateCustomerSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class CreateCustomerFailure extends CreateCustomerState {
  final BaseException error;

  const CreateCustomerFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
