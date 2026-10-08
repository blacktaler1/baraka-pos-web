import 'package:baraka_pos/features/cash/data/dto/transaction_item_dto.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';
import '../../domain/model/transaction_item_collection.dart';
import '../../domain/model/transaction_item_model.dart';

final class TransactionItemCollectionDto extends JsonCollectionDto<
    TransactionItemDto, TransactionItemCollection, TransactionItemModel> {
  final Json json;

  TransactionItemCollectionDto.fromJson(this.json)
      : super.fromJson(
          json,
          (e) => TransactionItemDto.fromJson(e),
        );

  TransactionItemCollectionDto.fromList(List<dynamic> list)
      : json = {"data": list},
        super.fromJson(
          {"data": list},
          (e) => TransactionItemDto.fromJson(e),
        );

  @override
  TransactionItemCollection collection() {
    return TransactionItemCollection(
      models: items.map((e) => e.model()).toList(),
    );
  }
}
