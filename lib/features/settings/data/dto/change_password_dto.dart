import 'package:baraka_pos/features/settings/domain/model/change_password_model.dart';
import '../../../../shared/shared.dart';

final class ChangePasswordDto extends JsonDto<ChangePasswordModel> {
  final Json json;

  ChangePasswordDto.fromJson(this.json) : super.fromJson(json);

  String get detail => json.text("detail");

  @override
  ChangePasswordModel model() {
    return ChangePasswordModel(detail: detail);
  }
}
