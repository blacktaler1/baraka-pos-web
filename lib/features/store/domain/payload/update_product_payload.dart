import '../../../../shared/domain/domain.dart';

final class UpdateProductPayload extends Payload {
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
  final double? minStock;

  const UpdateProductPayload({
    required this.id,
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
    required this.wholesalePrice,
    required this.minStock,
  });

  @override
  List<Object> get props => [
        "title: $title",
        "cost: $cost",
        "price: $price",
        "stock: $stock",
        "category_id: $categoryId",
        "unit: $unit",
        "pack_size: $packSize",
        "image_ids: $imagesIds",
        "qrCode: $qrCode",
        "firma_id: $firmaId",
        "wholesale_price: $wholesalePrice",
        "min_stock: $minStock",
      ];
}
