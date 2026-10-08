part of 'post_media_bloc.dart';

sealed class PostMediaState extends Equatable {
  const PostMediaState();

  T when<T>({
    required T Function() initial,
    required T Function() inPrepare,
    required T Function(MediaModel model) success,
    required T Function(BaseException error) failure,
  }) {
    return switch (this) {
      PostMediaInitial() => initial(),
      PostMediaPrepare() => inPrepare(),
      PostMediaSuccess(:final model) => success(model),
      PostMediaFailure(:final error) => failure(error),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? inPrepare,
    T Function(MediaModel model)? success,
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
    T Function(MediaModel model)? success,
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

final class PostMediaInitial extends PostMediaState {}

final class PostMediaPrepare extends PostMediaState {}

final class PostMediaSuccess extends PostMediaState {
  final MediaModel model;

  const PostMediaSuccess({required this.model});

  @override
  List<Object> get props => [
        "model: $model",
      ];
}

final class PostMediaFailure extends PostMediaState {
  final BaseException error;

  const PostMediaFailure({required this.error});

  @override
  List<Object> get props => [
        "error: $error",
      ];
}
