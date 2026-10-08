import 'package:baraka_pos/shared/shared.dart';

class StockHistoryItemModel extends Model {
  final int id;
  final StockProductModel product;
  final String quantity;
  final String costPrice;
  final String totalCost;
  final String type;
  final DateTime created;

  const StockHistoryItemModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.costPrice,
    required this.totalCost,
    required this.type,
    required this.created,
  });

  @override
  List<String> get props => [
        'id:$id',
        'product:$product',
        'quantity:$quantity',
        'costPrice:$costPrice',
        'totalCost:$totalCost',
        'type:$type',
        'created:$created',
      ];
}

final class StockProductModel extends Model {
  final String title;
  final String unit;
  final String qrCode;
  final List images;

  const StockProductModel({
    required this.title,
    required this.unit,
    required this.qrCode,
    required this.images,
  });

  @override
  List<String> get props => [
        "title: $title",
        "unit: $unit",
        "qrCode: $qrCode",
        "images: $images",
      ];
}
