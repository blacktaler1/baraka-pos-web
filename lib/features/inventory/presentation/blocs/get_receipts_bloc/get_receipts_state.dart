part of 'get_receipts_bloc.dart';

sealed class GetReceiptsState extends Equatable {
  const GetReceiptsState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(GetReceiptsModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      GetReceiptsInitial() => initial(),
      GetReceiptsPrepare() => inPrepare(),
      GetReceiptsSuccess(:final model) => success(model),
      GetReceiptsFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(GetReceiptsModel model)? success,
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
    T Function(GetReceiptsModel model)? success,
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

final class GetReceiptsInitial extends GetReceiptsState {}

final class GetReceiptsPrepare extends GetReceiptsState {}

final class GetReceiptsSuccess extends GetReceiptsState {
  final GetReceiptsModel model;

  const GetReceiptsSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class GetReceiptsFailure extends GetReceiptsState {
  final BaseException error;

  const GetReceiptsFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
