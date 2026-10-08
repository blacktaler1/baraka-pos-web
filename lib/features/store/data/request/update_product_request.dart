import 'package:baraka_pos/features/store/domain/domain.dart';
import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

final class UpdateProductRequest extends RemoteRequest<UpdateProductPayload> {
  final int id;
  final String title;
  final int cost;
  final int price;
  final double stock;
  final int categoryId;
  final String unit;
  final int packSize;
  final List imagesIds;
  final String qrCode;
  final int firmaId;
  final int? wholesalePrice;
  final int? meterPrice;
  final double? minStock;

  UpdateProductRequest.fromPayload(super.payload)
      : title = payload.title,
        cost = payload.cost,
        price = payload.price,
        stock = payload.stock,
        categoryId = payload.categoryId,
        unit = payload.unit,
        packSize = payload.packSize,
        imagesIds = payload.imagesIds,
        qrCode = payload.qrCode,
        firmaId = payload.firmaId,
        wholesalePrice = payload.wholesalePrice,
        meterPrice = payload.meterPrice,
        minStock = payload.minStock,
        id = payload.id,
        super.fromPayload();

  @override
  Json data() {
    final map = <String, dynamic>{
      if (title.isNotEmpty) "title": title,
      if (cost != 0) "cost": cost,
      if (price != 0) "price": price,
      if (stock != 0) "stock": stock,
      if (categoryId != 0) "category_id": categoryId,
      if (unit.isNotEmpty) "unit": unit,
      if (packSize != 0) "pack_size": packSize,
      if (imagesIds.isNotEmpty) "image_ids": imagesIds,
      if (qrCode.isNotEmpty) "qr_code": qrCode,
      if (firmaId != 0) "firma_id": firmaId,
    };

    map.removeWhere((key, value) => value == null);
    return {
      ...map,
      "wholesale_price": wholesalePrice,
      if (meterPrice != null) "meter_price": meterPrice,
      "min_stock": minStock,
    };
  }

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
