import 'package:baraka_pos/shared/domain/domain.dart';

final class WriteOffModel extends Model {
  final int id;
  final String productTitle;
  final String productUnit;
  final String barcode;
  final String quantity;
  final String costPrice;
  final String totalCost;
  final String reason;
  final String note;
  final String userName;
  final String created;

  const WriteOffModel({
    required this.id,
    required this.productTitle,
    required this.productUnit,
    required this.barcode,
    required this.quantity,
    required this.costPrice,
    required this.totalCost,
    required this.reason,
    required this.note,
    required this.userName,
    required this.created,
  });

  @override
  List<String> get props => [
        "id: $id",
        "productTitle: $productTitle",
        "productUnit: $productUnit",
        "barcode: $barcode",
        "quantity: $quantity",
        "costPrice: $costPrice",
        "totalCost: $totalCost",
        "reason: $reason",
        "note: $note",
        "userName: $userName",
        "created: $created",
      ];
}
