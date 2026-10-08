part of 'get_firma_bloc.dart';

sealed class GetFirmaState extends Equatable {
  const GetFirmaState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(AllFirmaModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      GetFirmaInitial() => initial(),
      GetFirmaPrepare() => inPrepare(),
      GetFirmaSuccess(:final model) => success(model),
      GetFirmaFailure(:final error) => failure(error),
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

final class GetFirmaInitial extends GetFirmaState {}

final class GetFirmaPrepare extends GetFirmaState {}

final class GetFirmaSuccess extends GetFirmaState {
  final AllFirmaModel model;

  const GetFirmaSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class GetFirmaFailure extends GetFirmaState {
  final BaseException error;

  const GetFirmaFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
