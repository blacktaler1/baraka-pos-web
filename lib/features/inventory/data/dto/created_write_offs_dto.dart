import 'package:baraka_pos/shared/aplication/aplication.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/domain.dart';
import 'dto.dart';

final class CreatedWriteOffsDto extends JsonDto<WriteOffCollection> {
  final Json json;

  const CreatedWriteOffsDto.fromJson(this.json) : super.fromJson(json);

  @override
  WriteOffCollection model() {
    return WriteOffCollectionDto.fromList(json.items("data")).collection();
  }
}
