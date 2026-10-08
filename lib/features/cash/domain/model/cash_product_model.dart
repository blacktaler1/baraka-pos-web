import 'package:baraka_pos/shared/domain/domain.dart';

final class CashProductModel extends Model {
  final int id;
  final String title;
  final String cost;
  final String price;
  final String wholesalePrice;
  final String stock;
  final String categoryTitle;
  final String unit;
  final int packSize;

  /// Rulon uchun 1 metr narxi (bo'sh — dona narxi / metr)
  final String meterPrice;
  final String qrcode;
  final int warehouse;
  final String images;

  const CashProductModel({
    required this.id,
    required this.title,
    required this.cost,
    required this.price,
    this.wholesalePrice = "",
    required this.stock,
    required this.categoryTitle,
    required this.unit,
    required this.packSize,
    this.meterPrice = "",
    required this.qrcode,
    required this.warehouse,
    required this.images,
  });

  @override
  List<String> get props => [
        "id: $id",
        "title: $title",
        "cost: $cost",
        "price: $price",
        "wholesale_price: $wholesalePrice",
        "stock: $stock",
        "title: $categoryTitle",
        "unit: $unit",
        "pack_size: $packSize",
        "meter_price: $meterPrice",
        "qr_code: $qrcode",
        "warehouse: $warehouse",
        "images: $images",
      ];
}
