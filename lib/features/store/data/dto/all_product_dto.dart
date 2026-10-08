import 'package:baraka_pos/features/store/data/data.dart';
import 'package:baraka_pos/features/store/domain/model/all_product_model.dart';
import 'package:baraka_pos/shared/shared.dart';

final class AllProductDto extends JsonDto<AllProductModel> {
  final Json json;

  AllProductDto.fromJson(this.json) : super.fromJson(json);
  String get next => json['next'] ?? "";

  String get previous => json.text('previous');

  int get total => json.integer('total');
  AllProductCollectionDto get allProduct =>
      AllProductCollectionDto.fromList(json.items("data"));

  num get totalStockValue => json.number("total_stock_value");

  @override
  AllProductModel model() {
    return AllProductModel(
      next: next,
      previous: previous,
      total: total,
      collection: allProduct.collection(),
      totalStockValue: totalStockValue,
    );
  }
}
