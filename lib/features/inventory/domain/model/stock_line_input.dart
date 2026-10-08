final class StockLineInput {
  final int productId;
  final double quantity;
  final int? unitCost;
  final int? newPrice;

  const StockLineInput({
    required this.productId,
    required this.quantity,
    this.unitCost,
    this.newPrice,
  });

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
        if (unitCost != null) "unit_cost": unitCost,
        if (newPrice != null) "new_price": newPrice,
      };

  @override
  String toString() => "StockLineInput(${toJson()})";
}
