import 'package:baraka_pos/shared/domain/domain.dart';

final class TransactionItemModel extends Model {
  final int id;
  final int productId;
  final String productTitle;
  final String productUnit;
  final num productPrice;
  final String quantity;
  final String subtotal;
  final String status;
  final int packSize;

  /// Pachkadan dona yoki rulondan metr sotilganmi
  final bool isPieceSale;

  const TransactionItemModel({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.productUnit,
    required this.productPrice,
    required this.quantity,
    required this.subtotal,
    required this.status,
    required this.packSize,
    this.isPieceSale = false,
  });

  @override
  List<String> get props => [
        "id: $id",
        "id: $productId",
        "title: $productTitle",
        "unit: $productUnit",
        "price: $productPrice",
        "quantity: $quantity",
        "subtotal: $subtotal",
        "status: $status",
        "pack_size: $packSize",
        "is_piece_sale: $isPieceSale",
      ];
}
