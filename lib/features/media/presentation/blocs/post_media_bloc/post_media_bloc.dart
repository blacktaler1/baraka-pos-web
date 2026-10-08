import 'package:cross_file/cross_file.dart';

import 'package:bloc/bloc.dart';
import 'package:baraka_pos/features/media/media.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';

part 'post_media_event.dart';
part 'post_media_state.dart';

class PostMediaBloc extends Bloc<PostMediaEvent, PostMediaState> {
  final MediaRepository repository;
  PostMediaBloc({required this.repository}) : super(PostMediaInitial()) {
    on<PostMediaStarted>(_onPostMediaStarted);
  }

  Future<void> _onPostMediaStarted(
    PostMediaStarted event,
    Emitter<PostMediaState> emit,
  ) async {
    emit(PostMediaInitial());

    emit(PostMediaPrepare());

    final result = await repository.postImage(
      payload: PostMediaPayload(image: event.image),
    );

    result.when(
      success: (model) => emit(
        PostMediaSuccess(model: model),
      ),
      failure: (error) => emit(
        PostMediaFailure(error: error),
      ),
    );
  }
}
