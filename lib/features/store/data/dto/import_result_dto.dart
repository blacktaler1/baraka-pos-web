import 'package:baraka_pos/features/store/domain/domain.dart';
import 'package:baraka_pos/shared/aplication/aplication.dart';
import 'package:baraka_pos/shared/data/data.dart';

final class ImportResultDto extends JsonDto<ImportResultModel> {
  final Json json;

  const ImportResultDto.fromJson(this.json) : super.fromJson(json);

  int get created => json.integer("created");
  int get updated => json.integer("updated");

  @override
  ImportResultModel model() {
    return ImportResultModel(created: created, updated: updated);
  }
}
