import 'package:baraka_pos/shared/domain/domain.dart';

final class CreateCategoryPayload extends Payload {
  final String title;
  final List imageIds;

  const CreateCategoryPayload({
    required this.title,
    required this.imageIds,
  });

  @override
  List<Object> get props => [
        "title: $title",
        "imageIds: $imageIds",
      ];
}
