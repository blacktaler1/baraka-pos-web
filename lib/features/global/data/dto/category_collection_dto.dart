import 'package:baraka_pos/features/global/data/data.dart';
import 'package:baraka_pos/features/global/domain/domain.dart';
import 'package:baraka_pos/shared/aplication/aplication.dart';
import 'package:baraka_pos/shared/data/data.dart';

final class CategoryCollectionDto
    extends JsonCollectionDto<CategoryDto, CategoryCollection, CategoryModel> {
  final Json json;

  CategoryCollectionDto.fromJson(this.json)
      : super.fromJson(
          json,
          (e) => CategoryDto.fromJson(e),
        );
  CategoryCollectionDto.fromList(List list)
      : json = {"data": list},
        super.fromJson(
          {"data": list},
          (e) => CategoryDto.fromJson(e),
        );

  @override
  CategoryCollection collection() {
    return CategoryCollection(
      models: items.map((e) => e.model()).toList(),
    );
  }
}
