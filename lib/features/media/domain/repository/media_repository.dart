import 'package:baraka_pos/features/media/media.dart';
import 'package:baraka_pos/shared/aplication/aplication.dart';

abstract class MediaRepository {
  Future<Safed<BaseException, MediaModel>> postImage({
    required PostMediaPayload payload,
  });
}
