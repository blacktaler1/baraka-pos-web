import 'package:baraka_pos/features/auth/auth.dart';
import 'package:baraka_pos/features/global/domain/domain.dart';
import 'package:baraka_pos/shared/shared.dart';

final class CategoryDto extends JsonDto<CategoryModel> {
  final Json json;

  CategoryDto.fromJson(this.json) : super.fromJson(json);

  int get id => json.integer("id");

  String get title => json.text("title");

  String get images {
    final imageModels =
        ImageCollectionDto.fromList(json["images"] ?? []).collection().models;
    return imageModels.lastOrNull?.file ?? "";
  }

  @override
  CategoryModel model() {
    return CategoryModel(
      id: id,
      title: title,
      image: images,
    );
  }
}
