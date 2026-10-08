import '../../../../shared/aplication/types/json.dart';
import '../../../../shared/data/data.dart';
import '../../domain/model/delete_category_model.dart';

final class DeleteCategoryDto extends JsonDto<DeleteCategoryModel> {
  final Json json;

  DeleteCategoryDto.fromJson(this.json) : super.fromJson(json);

  String get detail => json["detail"] ?? "";

  @override
  DeleteCategoryModel model() {
    return DeleteCategoryModel(
      detail: detail,
    );
  }
}
