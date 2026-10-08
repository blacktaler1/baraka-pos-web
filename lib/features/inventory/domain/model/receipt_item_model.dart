import 'package:baraka_pos/shared/domain/domain.dart';

final class ReceiptItemModel extends Model {
  final int id;
  final int productId;
  final String productTitle;
  final String productUnit;
  final String barcode;
  final String quantity;
  final String unitCost;
  final String newPrice;
  final String totalCost;

  const ReceiptItemModel({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.productUnit,
    required this.barcode,
    required this.quantity,
    required this.unitCost,
    required this.newPrice,
    required this.totalCost,
  });

  @override
  List<String> get props => [
        "id: $id",
        "productId: $productId",
        "productTitle: $productTitle",
        "productUnit: $productUnit",
        "barcode: $barcode",
        "quantity: $quantity",
        "unitCost: $unitCost",
        "newPrice: $newPrice",
        "totalCost: $totalCost",
      ];
}
