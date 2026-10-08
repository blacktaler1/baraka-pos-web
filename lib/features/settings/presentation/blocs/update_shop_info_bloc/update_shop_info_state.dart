part of 'update_shop_info_bloc.dart';

sealed class UpdateShopInfoState extends Equatable {
  const UpdateShopInfoState();
  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(UpdateShopInfoModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      UpdateShopInfoInitial() => initial(),
      UpdateShopInfoPrepare() => inPrepare(),
      UpdateShopInfoSuccess(:final model) => success(model),
      UpdateShopInfoFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(UpdateShopInfoModel model)? success,
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
    T Function(UpdateShopInfoModel model)? success,
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

final class UpdateShopInfoPrepare extends UpdateShopInfoState {}

final class UpdateShopInfoInitial extends UpdateShopInfoState {}

final class UpdateShopInfoSuccess extends UpdateShopInfoState {
  final UpdateShopInfoModel model;

  const UpdateShopInfoSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class UpdateShopInfoFailure extends UpdateShopInfoState {
  final BaseException error;

  const UpdateShopInfoFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
