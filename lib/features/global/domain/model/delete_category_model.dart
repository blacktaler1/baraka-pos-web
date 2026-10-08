import 'package:baraka_pos/shared/domain/domain.dart';

final class DeleteCategoryModel extends Model {
  final String detail;

  const DeleteCategoryModel({
    required this.detail,
  });

  @override
  List<String> get props => [
        "detail: $detail",
      ];
}
