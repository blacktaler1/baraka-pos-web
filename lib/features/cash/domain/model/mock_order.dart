class OrderItem {
  final int productId;
  final String title;
  String price;
  final String retailPrice;
  final String wholesalePrice;
  double quantity;
  final String stock;
  final String unit;

  OrderItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
    required this.stock,
    required this.unit,
    String? retailPrice,
    this.wholesalePrice = "",
  }) : retailPrice = retailPrice ?? price;

  bool get hasWholesalePrice => wholesalePrice.isNotEmpty;

  String priceFor({required bool wholesale}) =>
      wholesale && hasWholesalePrice ? wholesalePrice : retailPrice;

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity.toString(),
      };

  Map<String, dynamic> toStorageJson() => {
        "product_id": productId,
        "title": title,
        "price": price,
        "retail_price": retailPrice,
        "wholesale_price": wholesalePrice,
        "quantity": quantity,
        "stock": stock,
        "unit": unit,
      };

  factory OrderItem.fromStorageJson(Map<String, dynamic> json) => OrderItem(
        productId: json["product_id"] as int,
        title: json["title"] as String,
        price: json["price"] as String,
        retailPrice: json["retail_price"] as String?,
        wholesalePrice: json["wholesale_price"] as String? ?? "",
        quantity: (json["quantity"] as num).toDouble(),
        stock: json["stock"] as String,
        unit: json["unit"] as String,
      );
}

class MockOrder {
  final int transactionId;
  final List<OrderItem> items;
  final bool wholesale;
  final double discountValue;
  final bool discountIsPercent;
  bool isSelected;

  MockOrder({
    required this.transactionId,
    required this.items,
    this.wholesale = false,
    this.discountValue = 0,
    this.discountIsPercent = true,
    this.isSelected = false,
  });

  double get subtotal => items.fold(
        0,
        (sum, item) => sum + double.parse(item.price) * item.quantity,
      );

  double get discountAmount {
    final amount =
        discountIsPercent ? subtotal * discountValue / 100 : discountValue;
    return amount.clamp(0, subtotal).roundToDouble();
  }

  double get grandTotal => subtotal - discountAmount;

  MockOrder copyWith({
    List<OrderItem>? items,
    bool? wholesale,
    double? discountValue,
    bool? discountIsPercent,
  }) {
    return MockOrder(
      transactionId: transactionId,
      items: items ?? this.items,
      wholesale: wholesale ?? this.wholesale,
      discountValue: discountValue ?? this.discountValue,
      discountIsPercent: discountIsPercent ?? this.discountIsPercent,
      isSelected: isSelected,
    );
  }

  Map<String, dynamic> toStorageJson() => {
        "transaction_id": transactionId,
        "wholesale": wholesale,
        "discount_value": discountValue,
        "discount_is_percent": discountIsPercent,
        "items": items.map((e) => e.toStorageJson()).toList(),
      };

  factory MockOrder.fromStorageJson(Map<String, dynamic> json) => MockOrder(
        transactionId: json["transaction_id"] as int,
        wholesale: json["wholesale"] as bool? ?? false,
        discountValue: (json["discount_value"] as num?)?.toDouble() ?? 0,
        discountIsPercent: json["discount_is_percent"] as bool? ?? true,
        items: (json["items"] as List)
            .map((e) => OrderItem.fromStorageJson(e as Map<String, dynamic>))
            .toList(),
      );
}
