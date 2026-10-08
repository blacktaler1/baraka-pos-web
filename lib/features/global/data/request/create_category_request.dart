import 'package:baraka_pos/features/global/domain/domain.dart';
import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

final class CreateCategoryRequest extends RemoteRequest<CreateCategoryPayload> {
  final String title;
  final List imageIds;
  CreateCategoryRequest.fromPayload(super.payload)
      : title = payload.title,
        imageIds = payload.imageIds,
        super.fromPayload();

  @override
  Json data() => {
        "title": title,
        "image_ids": imageIds,
      };

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
