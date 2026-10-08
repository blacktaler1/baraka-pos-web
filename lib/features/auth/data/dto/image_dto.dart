import 'package:baraka_pos/features/auth/auth.dart';
import 'package:baraka_pos/shared/shared.dart';

final class ImageDto extends JsonDto<ImageModel> {
  final Json json;

  ImageDto.fromJson(this.json) : super.fromJson(json);

  int get id => json.integer('id');

  String get file => json['file'] ?? "";

  @override
  ImageModel model() {
    return ImageModel(
      id: id,
      file: file,
    );
  }
}
