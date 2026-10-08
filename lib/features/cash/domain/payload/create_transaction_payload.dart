import '../../../../shared/domain/domain.dart';
import '../model/create_item_collection.dart';
import '../model/create_item_model.dart';

final class CreateTransactionPayload extends Payload {
  final String paymentMethod;
  final int customer;
  final int paidAmount;
  final String deadline;
  final String description;
  final int discount;
  final CreateItemCollection items;

  const CreateTransactionPayload({
    required this.paymentMethod,
    required this.customer,
    required this.paidAmount,
    required this.deadline,
    required this.description,
    this.discount = 0,
    required this.items,
  });

  Map<String, dynamic> toJson() => {
        "payment_method": paymentMethod,
        "customer": customer,
        "paid_amount": paidAmount,
        "deadline": deadline,
        "description": description,
        "discount": discount,
        "items": items.models.map((e) => e.toJson()).toList(),
      };

  factory CreateTransactionPayload.fromJson(Map<String, dynamic> json) {
    return CreateTransactionPayload(
      paymentMethod: json["payment_method"] ?? '',
      customer: _toInt(json["customer"]),
      paidAmount: _toInt(json["paid_amount"]),
      deadline: json["deadline"] ?? '',
      description: json["description"] ?? '',
      discount: _toInt(json["discount"]),
      items: CreateItemCollection(
        models: (json["items"] as List? ?? [])
            .map(
              (e) => CreateItemModel(
                productId: _toInt(e["product_id"]),
                quantity: e["quantity"],
                price: _toInt(e["price"]),
                isPiece: e["is_piece"] == true,
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  List<String> get props => [
        "payment_method: $paymentMethod",
        "discount: $discount",
        "items: $items",
      ];
}

int _toInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}
