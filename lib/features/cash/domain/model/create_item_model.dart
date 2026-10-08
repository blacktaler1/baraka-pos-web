import '../../../../shared/domain/domain.dart';

final class CreateItemModel extends Model {
  final int productId;
  final String quantity;
  final int? price;

  /// Rulondan metr (yoki pachkadan dona) sotilmoqda
  final bool isPiece;

  const CreateItemModel({
    required this.productId,
    required this.quantity,
    this.price,
    this.isPiece = false,
  });

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
        if (price != null) "price": price,
        if (isPiece) "is_piece": true,
      };

  @override
  List<String> get props => [
        "product_id: $productId",
        "quantity: $quantity",
        "price: $price",
        "is_piece: $isPiece",
      ];
}
