import 'package:baraka_pos/features/settings/domain/domain.dart';

import '../../../../shared/shared.dart';

final class LastVersionDto extends JsonDto<LastVersionModel> {
  final Json json;

  LastVersionDto.fromJson(this.json) : super.fromJson(json);

  int get id => json.integer("id");

  String get url => json.text("url");

  String get version => json.text("version");

  String get build => json.text("build");

  String get created => json.text("created");

  String get modified => json.text("modified");

  bool get isMajor => json.flag("major_version");

  @override
  LastVersionModel model() {
    return LastVersionModel(
      id: id,
      url: url,
      version: version,
      build: build,
      created: created,
      modified: modified,
      isMajor: isMajor,
    );
  }
}
