import 'package:baraka_pos/shared/domain/domain.dart';

import 'item_collection.dart';
import 'transaction_details_model.dart';

final class ByCustomerItemModel extends Model {
  final int id;
  final String paid;
  final String debt;
  final bool isPaid;
  final String deadline;
  final String created;
  final TransactionDetailsModel details;
  final ItemCollection items;

  const ByCustomerItemModel({
    required this.id,
    required this.paid,
    required this.debt,
    required this.isPaid,
    required this.deadline,
    required this.created,
    required this.details,
    required this.items,
  });

  @override
  List<String> get props => [
        "id: $id",
        "paid: $paid",
        "debt: $debt",
        "isPaid: $isPaid",
        "deadline: $deadline",
        "created: $created",
        "details: $details",
        "items: $items",
      ];
}
