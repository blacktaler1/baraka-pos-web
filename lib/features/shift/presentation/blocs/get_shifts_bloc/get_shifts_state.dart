part of 'get_shifts_bloc.dart';

sealed class GetShiftsState extends Equatable {
  const GetShiftsState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(GetShiftsModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      GetShiftsInitial() => initial(),
      GetShiftsPrepare() => inPrepare(),
      GetShiftsSuccess(:final model) => success(model),
      GetShiftsFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(GetShiftsModel model)? success,
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
    T Function()? inPrepare,
    T Function(GetShiftsModel model)? success,
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

final class GetShiftsInitial extends GetShiftsState {}

final class GetShiftsPrepare extends GetShiftsState {}

final class GetShiftsSuccess extends GetShiftsState {
  final GetShiftsModel model;

  const GetShiftsSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class GetShiftsFailure extends GetShiftsState {
  final BaseException error;

  const GetShiftsFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
