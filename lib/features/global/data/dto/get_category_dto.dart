import 'package:baraka_pos/features/global/data/data.dart';
import 'package:baraka_pos/features/global/domain/model/get_category_model.dart';

import '../../../../shared/shared.dart';

final class GetCategoryDto extends JsonDto<GetCategoryModel> {
  final Json json;

  GetCategoryDto.fromJson(this.json) : super.fromJson(json);

  String get next => json.text("next");
  String get previous => json.text("previous");
  int get total => json.integer("total");

  CategoryCollectionDto get categoryCollection {
    final list = json["data"] as List? ?? [];
    return CategoryCollectionDto.fromList(list);
  }

  @override
  GetCategoryModel model() {
    return GetCategoryModel(
      next: next,
      previous: previous,
      total: total,
      collection: categoryCollection.collection(),
    );
  }
}
