import 'package:baraka_pos/features/media/media.dart';
import 'package:baraka_pos/shared/aplication/exceptions/base_exception.dart';
import 'package:baraka_pos/shared/aplication/utils/safed.dart';

final class MediaRepositoryImpl extends MediaRepository {
  final MediaRemoteSource remote;

  MediaRepositoryImpl({required this.remote});

  @override
  Future<Safed<BaseException, MediaModel>> postImage({
    required PostMediaPayload payload,
  }) async {
    final request = MediaRequest.fromPayload(payload);

    final result = await remote.postImage(request: request);

    return result.map(
      success: (dto) => dto.model(),
      failure: (BaseException e) => e,
    );
  }
}
