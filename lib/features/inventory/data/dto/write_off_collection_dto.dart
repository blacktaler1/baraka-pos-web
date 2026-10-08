import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/domain.dart';
import 'dto.dart';

final class WriteOffCollectionDto
    extends JsonCollectionDto<WriteOffDto, WriteOffCollection, WriteOffModel> {
  final Json json;

  WriteOffCollectionDto.fromList(List<dynamic> list)
      : json = {"data": list},
        super.fromJson({"data": list}, (e) => WriteOffDto.fromJson(e));

  @override
  WriteOffCollection collection() {
    return WriteOffCollection(models: items.map((e) => e.model()).toList());
  }
}
