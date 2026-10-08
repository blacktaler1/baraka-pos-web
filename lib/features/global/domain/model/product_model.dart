import 'package:baraka_pos/features/auth/auth.dart';
import 'package:baraka_pos/features/firma/domain/domain.dart';
import 'package:baraka_pos/features/global/domain/domain.dart';
import 'package:baraka_pos/shared/domain/domain.dart';

final class ProductModel extends Model {
  final int id;
  final String title;
  final String cost;
  final String price;
  final String wholesalePrice;
  final num margin;
  final String stock;
  final String minStock;
  final CategoryModel category;
  final String unit;
  final int packSize;
  final ImageCollection imageCollection;
  final String qrCode;
  final int warehouseId;
  final FirmaModel? firma;

  const ProductModel({
    required this.id,
    required this.title,
    required this.cost,
    required this.price,
    this.wholesalePrice = "",
    required this.margin,
    required this.stock,
    this.minStock = "",
    required this.category,
    required this.packSize,
    required this.unit,
    required this.imageCollection,
    required this.qrCode,
    required this.warehouseId,
    required this.firma,
  });

  @override
  List<String> get props => [
        "id: $id",
        "title: $title",
        "cost: $cost",
        "price: $price",
        "wholesale_price: $wholesalePrice",
        "margin: $margin",
        "stock: $stock",
        "min_stock: $minStock",
        "category: $category",
        "pack_size: $packSize",
        "unit: $unit",
        "collection: $imageCollection",
        "qrCode: $qrCode",
        "warehouseId: $warehouseId",
        "firma: $firma",
      ];
}

// "id": 4,
//   "title": "Coca Cola 0.5",
//   "cost": "5000.00",
//   "price": "7000.00",
//   "stock": 500,
//   "category": {
//       "id": 1,
//       "images": [],
//       "created": "2025-11-30T12:36:26.546358Z",
//       "modified": "2025-11-30T12:36:26.546358Z",
//       "title": "shirinliklar"
//   },
//   "unit": "dona",
//   "images": [],
//   "qr_code": "1224443532",
//   "warehouse": 4,
//   "firma": {
//       "id": 10,
//       "title": "Coca Cola",
//       "phone": "+998931546789",
//       "address": "Bog'i Bo'ston 128",
//       "warehouse": 4,
//       "images": [],
//       "created": "2025-12-02T07:01:15.098789Z",
//       "modified": "2025-12-02T07:01:15.098789Z",
//       "deleted_at": null
//   },
//   "created": "2025-12-02T07:01:26.389460Z",
//   "modified": "2025-12-02T07:01:26.389460Z",
//   "deleted_at": null
