import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';
import '../../domain/model/image_collection.dart';
import '../../domain/model/image_model.dart';
import 'image_dto.dart';

final class ImageCollectionDto
    extends JsonCollectionDto<ImageDto, ImageCollection, ImageModel> {
  final Json json;

  ImageCollectionDto.fromJson(this.json)
      : super.fromJson(
          json,
          (e) => ImageDto.fromJson(e),
        );
  ImageCollectionDto.fromList(List list)
      : json = {"data": list},
        super.fromJson(
          {"data": list},
          (e) => ImageDto.fromJson(e),
        );
  @override
  ImageCollection collection() {
    return ImageCollection(
      models: items.map((e) => e.model()).toList(),
    );
  }
}
