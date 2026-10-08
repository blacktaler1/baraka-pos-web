import 'package:baraka_pos/features/cash/cash.dart';
import 'package:baraka_pos/shared/aplication/aplication.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../auth/data/dto/image_collection_dto.dart';

final class CashProductDto extends JsonDto<CashProductModel> {
  final Json json;

  const CashProductDto.fromJson(this.json) : super.fromJson(json);

  int get id => json.integer('id');

  String get title => json.text('title');

  String get cost => json.text('cost', fallback: "0");

  String get price => json.text('price', fallback: "0");

  String get wholesalePrice => json.text('wholesale_price');

  String get stock => json.text('stock', fallback: "0");

  String get categoryTitle => json.object('category').text('title');

  String get unit => json.text('unit');

  int get packSize => json.integer('pack_size');

  String get qrcode => json.text('qr_code');

  int get warehouse => json.integer('warehouse');

  String get images {
    final imageModels =
        ImageCollectionDto.fromList(json.items("images")).collection().models;
    return imageModels.lastOrNull?.file ?? "";
  }

  @override
  CashProductModel model() {
    return CashProductModel(
      id: id,
      title: title,
      cost: cost,
      price: price,
      wholesalePrice: wholesalePrice,
      stock: stock,
      categoryTitle: categoryTitle,
      unit: unit,
      packSize: packSize,
      qrcode: qrcode,
      warehouse: warehouse,
      images: images,
    );
  }
}
