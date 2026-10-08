part of 'get_dashboard_bloc.dart';

sealed class GetDashboardState extends Equatable {
  const GetDashboardState();
  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(DashboardModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      GetDashboardInitial() => initial(),
      GetDashboardPrepare() => inPrepare(),
      GetDashboardSuccess(:final model) => success(model),
      GetDashboardFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(DashboardModel model)? success,
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
    T Function(DashboardModel model)? success,
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

final class GetDashboardInitial extends GetDashboardState {}

final class GetDashboardPrepare extends GetDashboardState {}

final class GetDashboardSuccess extends GetDashboardState {
  final DashboardModel model;

  const GetDashboardSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class GetDashboardFailure extends GetDashboardState {
  final BaseException error;

  const GetDashboardFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
