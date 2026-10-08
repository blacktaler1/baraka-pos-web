import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';
import '../../domain/model/cash_product_collection.dart';
import '../../domain/model/cash_product_model.dart';
import 'cash_product_dto.dart';

final class CashProductCollectionDto extends JsonCollectionDto<CashProductDto,
    CashProductCollection, CashProductModel> {
  final Json json;

  CashProductCollectionDto.fromJson(this.json)
      : super.fromJson(
          json,
          (e) => CashProductDto.fromJson(e),
        );

  CashProductCollectionDto.fromList(List<dynamic> list)
      : json = {"data": list},
        super.fromJson(
          {"data": list},
          (e) => CashProductDto.fromJson(e),
        );

  @override
  CashProductCollection collection() {
    return CashProductCollection(
      models: items.map((e) => e.model()).toList(),
    );
  }
}
