import 'package:baraka_pos/features/cash/domain/model/daily_product_collection.dart';
import 'package:baraka_pos/shared/shared.dart';

final class DailyProductCollectionDto extends JsonCollectionDto<
    DailyProctItemDto, DailyProductCollection, DailyProductItemModel> {
  final Json json;

  DailyProductCollectionDto.fromJson(this.json)
      : super.fromJson(
          json,
          (e) => DailyProctItemDto.fromJson(e),
        );
  DailyProductCollectionDto.fromList(List<dynamic> list)
      : json = {"data": list},
        super.fromJson(
          {"data": list},
          (e) => DailyProctItemDto.fromJson(e),
        );
  @override
  DailyProductCollection collection() {
    return DailyProductCollection(
      models: items
          .map(
            (e) => e.model(),
          )
          .toList(),
    );
  }
}

final class DailyProctItemDto extends JsonDto<DailyProductItemModel> {
  final Json json;

  DailyProctItemDto.fromJson(this.json) : super.fromJson(json);

  String get productName => json["product_name"]?.toString() ?? "";

  String get unit => json["unit"]?.toString() ?? "";

  String get quantity => parseAmount(json["quantity"]?.toString()).toString();

  String get totalSales =>
      parseAmount(json["total_sales"]?.toString()).toStringAsFixed(0);

  @override
  DailyProductItemModel model() {
    return DailyProductItemModel(
      productName: productName,
      unit: unit,
      quantity: quantity,
      totalSales: totalSales,
    );
  }
}
