import 'package:baraka_pos/shared/domain/domain.dart';
import 'receipt_item_collection.dart';

final class ReceiptModel extends Model {
  final int id;
  final String firmaTitle;
  final String userName;
  final String note;
  final String totalCost;
  final String paidAmount;
  final String debt;
  final String created;
  final ReceiptItemCollection items;

  const ReceiptModel({
    required this.id,
    required this.firmaTitle,
    required this.userName,
    required this.note,
    required this.totalCost,
    required this.paidAmount,
    required this.debt,
    required this.created,
    required this.items,
  });

  @override
  List<String> get props => [
        "id: $id",
        "firmaTitle: $firmaTitle",
        "userName: $userName",
        "note: $note",
        "totalCost: $totalCost",
        "paidAmount: $paidAmount",
        "debt: $debt",
        "created: $created",
        "items: $items",
      ];
}
