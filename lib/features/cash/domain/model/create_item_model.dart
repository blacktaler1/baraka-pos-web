import '../../../../shared/domain/domain.dart';

final class CreateItemModel extends Model {
  final int productId;
  final String quantity;
  final int? price;

  const CreateItemModel({
    required this.productId,
    required this.quantity,
    this.price,
  });

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
        if (price != null) "price": price,
      };

  @override
  List<String> get props => [
        "product_id: $productId",
        "quantity: $quantity",
        "price: $price",
      ];
}
