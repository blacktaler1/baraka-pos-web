import 'package:baraka_pos/features/cash/cash.dart';
import 'package:baraka_pos/shared/shared.dart';

final class UserDailyCheckDto extends JsonDto<UserDailyCheckModel> {
  final Json json;

  UserDailyCheckDto.fromJson(this.json) : super.fromJson(json);

  int get id => json.integer("id");

  String get name => json.text("name");

  @override
  UserDailyCheckModel model() {
    return UserDailyCheckModel(
      id: id,
      name: name,
    );
  }
}
