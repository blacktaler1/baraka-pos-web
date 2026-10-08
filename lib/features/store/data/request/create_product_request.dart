import 'package:baraka_pos/shared/shared.dart';

import '../../../global/global.dart';

final class CreateProductRequest extends RemoteRequest<CreateProductPayload> {
  final String title;
  final int cost;
  final int price;
  final double stock;
  final int categoryId;
  final String unit;
  final int packSize;
  final String qrCode;
  final List imageIds;
  final int firmaId;
  final int? wholesalePrice;
  final int? meterPrice;
  final double? minStock;
  CreateProductRequest.fromPayload(super.payload)
      : title = payload.title,
        cost = payload.cost,
        price = payload.price,
        stock = payload.stock,
        categoryId = payload.categoryId,
        unit = payload.unit,
        packSize = payload.packSize,
        qrCode = payload.qrCode,
        imageIds = payload.imagesIds,
        firmaId = payload.firmaId,
        wholesalePrice = payload.wholesalePrice,
        meterPrice = payload.meterPrice,
        minStock = payload.minStock,
        super.fromPayload();

  @override
  Json data() => {
        "title": title,
        "cost": cost,
        "price": price,
        "stock": stock,
        "category_id": categoryId,
        "unit": unit, // dona | litr | kg | metr
        if (packSize != 0) "pack_size": packSize,
        "image_ids": imageIds,
        "qr_code": qrCode,
        if (firmaId != 0) "firma_id": firmaId,
        if (wholesalePrice != null) "wholesale_price": wholesalePrice,
        if (meterPrice != null) "meter_price": meterPrice,
        if (minStock != null) "min_stock": minStock,
      };

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
