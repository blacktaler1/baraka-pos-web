part of 'get_by_id_firma_bloc.dart';

sealed class GetByIdFirmaState extends Equatable {
  const GetByIdFirmaState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(FirmaModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      GetByIdFirmaInitial() => initial(),
      GetByIdFirmaPrepare() => inPrepare(),
      GetByIdFirmaSuccess(:final model) => success(model),
      GetByIdFirmaFailure(:final error) => failure(error),
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

final class GetByIdFirmaInitial extends GetByIdFirmaState {}

final class GetByIdFirmaPrepare extends GetByIdFirmaState {}

final class GetByIdFirmaSuccess extends GetByIdFirmaState {
  final FirmaModel model;

  const GetByIdFirmaSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class GetByIdFirmaFailure extends GetByIdFirmaState {
  final BaseException error;

  const GetByIdFirmaFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
