import 'package:baraka_pos/features/media/media.dart';
import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

final class MediaDto extends JsonDto<MediaModel> {
  final Json json;

  MediaDto.fromJson(this.json) : super.fromJson(json);

  int get id => json.integer("id");

  String get imagePath => json.text("file");

  @override
  MediaModel model() {
    return MediaModel(
      id: id,
      imagePath: imagePath,
    );
  }
}
