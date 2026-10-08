part of 'debtor_firma_bloc.dart';

sealed class DebtorFirmaState extends Equatable {
  const DebtorFirmaState();
  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(AllFirmaModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      DebtorFirmaInitial() => initial(),
      DebtorFirmaPrepare() => inPrepare(),
      DebtorFirmaSuccess(:final model) => success(model),
      DebtorFirmaFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(AllFirmaModel model)? success,
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
    T Function(AllFirmaModel model)? success,
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

final class DebtorFirmaInitial extends DebtorFirmaState {}

final class DebtorFirmaPrepare extends DebtorFirmaState {}

final class DebtorFirmaSuccess extends DebtorFirmaState {
  final AllFirmaModel model;

  const DebtorFirmaSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class DebtorFirmaFailure extends DebtorFirmaState {
  final BaseException error;

  const DebtorFirmaFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
