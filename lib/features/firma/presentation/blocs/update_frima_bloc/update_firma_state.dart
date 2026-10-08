part of 'update_firma_bloc.dart';

sealed class UpdateFirmaState extends Equatable {
  const UpdateFirmaState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(FirmaModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      UpdateFirmaInitial() => initial(),
      UpdateFirmaPrepare() => inPrepare(),
      UpdateFirmaSuccess(:final model) => success(model),
      UpdateFirmaFailure(:final error) => failure(error),
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

final class UpdateFirmaInitial extends UpdateFirmaState {}

final class UpdateFirmaPrepare extends UpdateFirmaState {}

final class UpdateFirmaSuccess extends UpdateFirmaState {
  final FirmaModel model;

  const UpdateFirmaSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class UpdateFirmaFailure extends UpdateFirmaState {
  final BaseException error;

  const UpdateFirmaFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
