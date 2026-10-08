import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/domain.dart';
import 'dto.dart';

final class ReceiptItemCollectionDto extends JsonCollectionDto<ReceiptItemDto,
    ReceiptItemCollection, ReceiptItemModel> {
  final Json json;

  ReceiptItemCollectionDto.fromList(List<dynamic> list)
      : json = {"data": list},
        super.fromJson({"data": list}, (e) => ReceiptItemDto.fromJson(e));

  @override
  ReceiptItemCollection collection() {
    return ReceiptItemCollection(models: items.map((e) => e.model()).toList());
  }
}
