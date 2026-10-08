part of 'create_firma_bloc.dart';

sealed class CreateFirmaState extends Equatable {
  const CreateFirmaState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(FirmaModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      CreateFirmaInitial() => initial(),
      CreateFirmaPrepare() => inPrepare(),
      CreateFirmaSuccess(:final model) => success(model),
      CreateFirmaFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(FirmaModel model)? success,
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
    T Function(FirmaModel model)? success,
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

final class CreateFirmaInitial extends CreateFirmaState {}

final class CreateFirmaPrepare extends CreateFirmaState {}

final class CreateFirmaSuccess extends CreateFirmaState {
  final FirmaModel model;

  const CreateFirmaSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class CreateFirmaFailure extends CreateFirmaState {
  final BaseException error;

  const CreateFirmaFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
