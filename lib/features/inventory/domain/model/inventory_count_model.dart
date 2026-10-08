import 'package:baraka_pos/shared/domain/domain.dart';
import 'inventory_item_collection.dart';

final class InventoryCountModel extends Model {
  final int id;
  final String status;
  final String note;
  final String userName;
  final String created;
  final String completedAt;
  final int itemsCount;
  final InventoryItemCollection items;

  const InventoryCountModel({
    required this.id,
    required this.status,
    required this.note,
    required this.userName,
    required this.created,
    required this.completedAt,
    required this.itemsCount,
    required this.items,
  });

  @override
  List<String> get props => [
        "id: $id",
        "status: $status",
        "note: $note",
        "userName: $userName",
        "created: $created",
        "completedAt: $completedAt",
        "itemsCount: $itemsCount",
        "items: $items",
      ];
}
