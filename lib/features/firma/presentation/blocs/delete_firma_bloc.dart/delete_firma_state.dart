part of 'delete_firma_bloc.dart';

sealed class DeleteFirmaState extends Equatable {
  const DeleteFirmaState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(NoContentModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      DeleteFirmaInitial() => initial(),
      DeleteFirmaPrepare() => inPrepare(),
      DeleteFirmaSuccess(:final model) => success(model),
      DeleteFirmaFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(NoContentModel model)? success,
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
    T Function(NoContentModel model)? success,
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

final class DeleteFirmaPrepare extends DeleteFirmaState {}

final class DeleteFirmaInitial extends DeleteFirmaState {}

final class DeleteFirmaSuccess extends DeleteFirmaState {
  final NoContentModel model;

  const DeleteFirmaSuccess({required this.model});

  @override
  List<Object> get props => ["model: $model"];
}

final class DeleteFirmaFailure extends DeleteFirmaState {
  final BaseException error;

  const DeleteFirmaFailure({required this.error});

  @override
  // TODO: implement props
  List<Object> get props => ["error: $error"];
}
