import 'package:baraka_pos/shared/domain/domain.dart';

final class InventoryItemModel extends Model {
  final int id;
  final int productId;
  final String productTitle;
  final String productUnit;
  final String barcode;
  final String countedQuantity;
  final String expectedQuantity;
  final String currentStock;
  final String difference;
  final String costPrice;

  const InventoryItemModel({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.productUnit,
    required this.barcode,
    required this.countedQuantity,
    required this.expectedQuantity,
    required this.currentStock,
    required this.difference,
    required this.costPrice,
  });

  @override
  List<String> get props => [
        "id: $id",
        "productId: $productId",
        "productTitle: $productTitle",
        "productUnit: $productUnit",
        "barcode: $barcode",
        "countedQuantity: $countedQuantity",
        "expectedQuantity: $expectedQuantity",
        "currentStock: $currentStock",
        "difference: $difference",
        "costPrice: $costPrice",
      ];
}
