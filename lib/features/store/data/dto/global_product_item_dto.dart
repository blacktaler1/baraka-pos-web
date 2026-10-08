import 'package:baraka_pos/features/auth/auth.dart';
import 'package:baraka_pos/features/store/domain/domain.dart';

import '../../../../shared/shared.dart';

final class GlobalProductItemDto extends JsonDto<GlobalProductItemModel> {
  final Json json;

  GlobalProductItemDto.fromJson(this.json) : super.fromJson(json);

  String get title => json.text("title");

  String get unit => json.text("unit");

  String get qrCode => json.text("qr_code");

  ImageCollectionDto get images =>
      ImageCollectionDto.fromList(json.items("images"));

  @override
  GlobalProductItemModel model() {
    return GlobalProductItemModel(
      title: title,
      unit: unit,
      qrCode: qrCode,
      images: images.collection(),
    );
  }
}
