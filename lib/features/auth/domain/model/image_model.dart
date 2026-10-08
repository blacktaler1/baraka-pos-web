import '../../../../shared/domain/domain.dart';

final class ImageModel extends Model {
  final int id;
  final String file;

  const ImageModel({
    required this.id,
    required this.file,
  });

  @override
  List<String> get props => [
        "id: $id",
        "file: $file",
      ];
}
