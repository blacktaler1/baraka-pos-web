import 'package:baraka_pos/shared/domain/domain.dart';

import '../model/create_item_collection.dart';
import '../model/create_item_model.dart';

final class RefoundTransactionPayload extends Payload {
  final int transactionId;
  final String description;
  final CreateItemCollection items;

  const RefoundTransactionPayload({
    required this.description,
    required this.items,
    required this.transactionId,
  });

  Map<String, dynamic> toJson() => {
        "description": description,
        "items": items.models.map((e) => e.toJson()).toList(),
      };

  factory RefoundTransactionPayload.fromJson(Map<String, dynamic> json) {
    return RefoundTransactionPayload(
      transactionId: json["pk"],
      description: json["description"],
      items: CreateItemCollection(
        models: (json["items"] as List)
            .map(
              (e) => CreateItemModel(
                productId: e["product_id"],
                quantity: e["quantity"],
                price: e["price"],
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  List<String> get props => [
        "description: $description",
        "items: $items",
      ];
}
