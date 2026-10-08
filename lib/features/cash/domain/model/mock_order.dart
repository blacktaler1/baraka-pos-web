class OrderItem {
  final int productId;
  final String title;
  String price;
  final String retailPrice;
  final String wholesalePrice;
  double quantity;
  final String stock;
  final String unit;

  /// Rulon: 1 donadagi metr va 1 metr narxi
  final int packSize;
  final String meterPrice;

  /// Rulon qatorida: true — metrlab, false — butun dona sotiladi
  bool byPiece;

  OrderItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
    required this.stock,
    required this.unit,
    String? retailPrice,
    this.wholesalePrice = "",
    this.packSize = 0,
    this.meterPrice = "",
    this.byPiece = false,
  }) : retailPrice = retailPrice ?? price;

  bool get hasWholesalePrice => wholesalePrice.isNotEmpty;

  bool get isRoll => unit == 'roll' && packSize > 0;

  /// Backendga is_piece=true bilan yuboriladi (metrlab sotuv)
  bool get isPieceSale => isRoll && byPiece;

  double get _stockValue => double.tryParse(stock) ?? 0;

  /// Butun donalar soni (ochilgan rulon hisobga olinmaydi)
  int get fullPieces => (_stockValue + 1e-6).floor();

  /// Joriy rejimda sotish mumkin bo'lgan eng ko'p miqdor
  double get maxQuantity {
    if (!isRoll) return _stockValue;
    if (byPiece) return (_stockValue * packSize * 100).floorToDouble() / 100;
    return fullPieces.toDouble();
  }

  /// Savat qatorida ko'rinadigan birlik: metr yoki dona
  String get saleUnit => isRoll ? (byPiece ? 'metr' : 'dona') : unit;

  String priceFor({required bool wholesale}) {
    if (isPieceSale) {
      if (wholesale && hasWholesalePrice) {
        return (double.parse(wholesalePrice) / packSize).toStringAsFixed(2);
      }
      if (meterPrice.isNotEmpty) return meterPrice;
      return (double.parse(retailPrice) / packSize).toStringAsFixed(2);
    }
    return wholesale && hasWholesalePrice ? wholesalePrice : retailPrice;
  }

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
        "pack_size": packSize,
        "meter_price": meterPrice,
        "by_piece": byPiece,
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
        packSize: json["pack_size"] as int? ?? 0,
        meterPrice: json["meter_price"] as String? ?? "",
        byPiece: json["by_piece"] as bool? ?? false,
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
