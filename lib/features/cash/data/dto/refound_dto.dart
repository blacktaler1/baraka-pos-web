import 'package:baraka_pos/features/cash/cash.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';

final class RefoundDto extends JsonDto<RefoundModel> {
  final Json json;

  const RefoundDto.fromJson(this.json) : super.fromJson(json);

  String get status => json["status"] ?? "";

  String get message => json["message"] ?? "";

  @override
  RefoundModel model() {
    return RefoundModel(
      status: status,
      message: message,
    );
  }
}
