import 'package:baraka_pos/features/global/domain/domain.dart';
import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

final class UpdateCategoryRequest extends RemoteRequest<UpdateCategoryPayload> {
  final int pk;
  final String title;
  final List imageIds;
  UpdateCategoryRequest.fromPayload(super.payload)
      : pk = payload.pk,
        title = payload.title,
        imageIds = payload.imageIds,
        super.fromPayload();

  @override
  Json data() => {
        if (title.isNotEmpty) "title": title,
        if (imageIds.isNotEmpty) "image_ids": imageIds,
      };

  @override
  Map<String, String> path() => {
        "pk": pk.toString(),
      };

  @override
  Map<String, String> query() => {};
}
