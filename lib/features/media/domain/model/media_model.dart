import '../../../../shared/domain/domain.dart';

final class MediaModel extends Model {
  final int id;
  final String imagePath;

  const MediaModel({required this.id, required this.imagePath});

  @override
  List<String> get props => [
        "id: $id",
        "imagePath: $imagePath",
      ];
}
