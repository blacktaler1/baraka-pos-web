import 'package:baraka_pos/features/store/data/dto/dto.dart';
import 'package:baraka_pos/features/store/domain/domain.dart';
import 'package:baraka_pos/shared/shared.dart';

final class GlobalProductCollectionDto extends JsonCollectionDto<
    GlobalProductItemDto, GlobalProductCollection, GlobalProductItemModel> {
  final Json json;

  GlobalProductCollectionDto.fromJson(this.json)
      : super.fromJson(
          json,
          (e) => GlobalProductItemDto.fromJson(e),
        );
  GlobalProductCollectionDto.fromList(List list)
      : json = {"data": list},
        super.fromJson(
          {"data": list},
          (e) => GlobalProductItemDto.fromJson(e),
        );

  @override
  GlobalProductCollection collection() {
    return GlobalProductCollection(
      models: items.map((e) => e.model()).toList(),
    );
  }
}
