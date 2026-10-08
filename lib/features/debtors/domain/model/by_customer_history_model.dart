import '../../../../shared/domain/domain.dart';

final class ByCustomerHistoryModel extends Model {
  final int historyId;
  final String historyDate;
  final String historyUser;
  final String historyType;
  final int id;
  final String created;
  final String modified;
  final String paid;
  final String debt;
  final String description;
  final bool isPaid;
  final String deadline;
  final String paidDate;
  final String? historyChangeReason;
  final int customer;
  final int transaction;

  const ByCustomerHistoryModel({
    required this.historyId,
    required this.historyDate,
    required this.historyUser,
    required this.historyType,
    required this.id,
    required this.created,
    required this.modified,
    required this.paid,
    required this.debt,
    required this.description,
    required this.isPaid,
    required this.deadline,
    required this.paidDate,
    required this.historyChangeReason,
    required this.customer,
    required this.transaction,
  });

  @override
  List<String> get props => [
        "history_id: $historyId",
        "history_date: $historyDate",
        "history_user: $historyUser",
        "history_type: $historyType",
        "id: $id",
        "created: $created",
        "modified: $modified",
        "paid: $paid",
        "debt: $debt",
        "description: $description",
        "is_paid: $isPaid",
        "deadline: $deadline",
        "paid_date: $paidDate",
        "history_change_reason: $historyChangeReason",
        "customer: $customer",
        "transaction: $transaction",
      ];
}
