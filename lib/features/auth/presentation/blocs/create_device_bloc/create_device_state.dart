part of 'create_device_bloc.dart';

sealed class CreateDeviceState extends Equatable {
  const CreateDeviceState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(DeviceModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      CreateDeviceInitial() => initial(),
      CreateDevicePrepare() => inPrepare(),
      CreateDeviceSuccess(:final model) => success(model),
      CreateDeviceFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(DeviceModel model)? success,
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
    T Function(DeviceModel model)? success,
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

final class CreateDeviceInitial extends CreateDeviceState {}

final class CreateDevicePrepare extends CreateDeviceState {}

final class CreateDeviceSuccess extends CreateDeviceState {
  final DeviceModel model;

  const CreateDeviceSuccess({required this.model});

  @override
  List<Object> get props => ["model: $model"];
}

final class CreateDeviceFailure extends CreateDeviceState {
  final BaseException error;

  const CreateDeviceFailure({required this.error});

  @override
  List<Object> get props => ["error: $error"];
}
