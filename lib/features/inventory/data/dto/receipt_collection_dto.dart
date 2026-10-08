import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/domain.dart';
import 'dto.dart';

final class ReceiptCollectionDto
    extends JsonCollectionDto<ReceiptDto, ReceiptCollection, ReceiptModel> {
  final Json json;

  ReceiptCollectionDto.fromList(List<dynamic> list)
      : json = {"data": list},
        super.fromJson({"data": list}, (e) => ReceiptDto.fromJson(e));

  @override
  ReceiptCollection collection() {
    return ReceiptCollection(models: items.map((e) => e.model()).toList());
  }
}
