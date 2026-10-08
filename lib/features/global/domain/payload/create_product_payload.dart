import 'package:baraka_pos/shared/shared.dart';

final class CreateProductPayload extends Payload {
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
  final double? minStock;

  const CreateProductPayload({
    required this.title,
    required this.cost,
    required this.price,
    required this.stock,
    required this.categoryId,
    required this.unit,
    required this.packSize,
    required this.imagesIds,
    required this.qrCode,
    required this.firmaId,
    this.wholesalePrice,
    this.minStock,
  });

  @override
  List<Object> get props => [
        "title: $title",
        "cost: $cost",
        "price: $price",
        "stock: $stock",
        "categoryId: $categoryId",
        "unit: $unit",
        "packSize: $packSize",
        "imagesIds: $imagesIds",
        "qrCode: $qrCode",
        "firmaId: $firmaId",
        "wholesale_price: $wholesalePrice",
        "min_stock: $minStock",
      ];
}

// "title": "Coca Cola 0.5",
// "cost": 5000,
// "price": 7000,
// "stock": 500,
// "category_id": 1,
// "unit": "dona", // dona | litr | kg | metr
// "image_ids": [],
// "qr_code": "1224443531",
// "firma_id": 1
