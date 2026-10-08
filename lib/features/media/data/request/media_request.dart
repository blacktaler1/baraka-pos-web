import 'package:cross_file/cross_file.dart';

import 'package:baraka_pos/shared/shared.dart';

import '../../media.dart';

final class MediaRequest extends RemoteRequest<PostMediaPayload> {
  final XFile image;
  MediaRequest.fromPayload(super.payload)
      : image = payload.image,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
