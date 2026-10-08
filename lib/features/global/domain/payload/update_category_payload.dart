import 'package:baraka_pos/shared/domain/domain.dart';

final class UpdateCategoryPayload extends Payload {
  final int pk;
  final String title;
  final List imageIds;

  const UpdateCategoryPayload({
    required this.pk,
    required this.title,
    required this.imageIds,
  });

  @override
  List<Object> get props => [
        "pk: $pk",
        "title: $title",
        "imageIds: $imageIds",
      ];
}
