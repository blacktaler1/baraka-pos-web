part of 'create_loan_bloc.dart';

sealed class CreateLoanState extends Equatable {
  const CreateLoanState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(LoanFirmaModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      CreateLoanInitial() => initial(),
      CreateLoanPrepare() => inPrepare(),
      CreateLoanSuccess(:final model) => success(model),
      CreateLoanFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(LoanFirmaModel model)? success,
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
    T Function(LoanFirmaModel model)? success,
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

final class CreateLoanInitial extends CreateLoanState {}

final class CreateLoanPrepare extends CreateLoanState {}

final class CreateLoanSuccess extends CreateLoanState {
  final LoanFirmaModel model;

  const CreateLoanSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class CreateLoanFailure extends CreateLoanState {
  final BaseException error;

  const CreateLoanFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
