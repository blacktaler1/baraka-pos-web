import 'package:baraka_pos/shared/domain/domain.dart';

final class CategoryModel extends Model {
  final int id;
  final String title;
  final String image;

  const CategoryModel({
    required this.id,
    required this.title,
    required this.image,
  });

  @override
  List<String> get props => [
        "id: $id",
        "title: $title",
        "image: $image",
      ];
}
