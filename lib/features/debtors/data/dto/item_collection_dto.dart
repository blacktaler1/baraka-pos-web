import 'package:baraka_pos/features/debtors/data/data.dart';
import 'package:baraka_pos/features/debtors/domain/model/item_collection.dart';
import 'package:baraka_pos/features/debtors/domain/model/item_model.dart';
import 'package:baraka_pos/shared/shared.dart';

final class ItemCollectionDto
    extends JsonCollectionDto<ItemDto, ItemCollection, ItemModel> {
  final Json json;

  ItemCollectionDto.fromJson(this.json)
      : super.fromJson(
          json,
          (e) => ItemDto.fromJson(e),
        );
  ItemCollectionDto.fromList(List list)
      : json = {"data": list},
        super.fromJson(
          {"data": list},
          (e) => ItemDto.fromJson(e),
        );

  @override
  ItemCollection collection() {
    return ItemCollection(models: items.map((e) => e.model()).toList());
  }
}
