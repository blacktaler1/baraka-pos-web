import 'package:baraka_pos/features/global/domain/domain.dart';
import 'package:baraka_pos/shared/data/data.dart';

final class NoContentDto extends JsonDto<NoContentModel> {
  NoContentDto.fromJson(Map<String, dynamic>? json)
      : super.fromJson(json ?? const {});

  /// qulaylik uchun bo‘sh DTO
  const NoContentDto() : super.fromJson(const {});

  @override
  NoContentModel model() {
    return const NoContentModel();
  }
}
