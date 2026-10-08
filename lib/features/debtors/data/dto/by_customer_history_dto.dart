import '../../../../shared/aplication/types/json.dart';
import '../../../../shared/data/data.dart';
import '../../domain/model/by_customer_history_model.dart';

final class ByCustomerHistoryDto extends JsonDto<ByCustomerHistoryModel> {
  final Json json;

  ByCustomerHistoryDto.fromJson(this.json) : super.fromJson(json);

  int get historyId => json.integer("history_id");

  String get historyDate => json["history_date"] ?? "";

  String get historyUser => json["history_user"] ?? "";

  String get historyType => json["history_type"] ?? "";

  int get id => json.integer("id");

  String get created => json["created"] ?? "";

  String get modified => json["modified"] ?? "";

  String get paid => json.text("paid", fallback: "0");

  String get debt => json.text("debt", fallback: "0");

  String get description => json["description"] ?? "";

  bool get isPaid => json["is_paid"] ?? false;

  String get deadline => json["deadline"] ?? "";

  String get paidDate => json["paid_date"] ?? "";

  String? get historyChangeReason => json["history_change_reason"] ?? "";

  int get customer => json.integer("customer");

  int get transaction => json.integer("transaction");

  @override
  ByCustomerHistoryModel model() {
    return ByCustomerHistoryModel(
      historyId: historyId,
      historyDate: historyDate,
      historyUser: historyUser,
      historyType: historyType,
      id: id,
      created: created,
      modified: modified,
      paid: paid,
      debt: debt,
      description: description,
      isPaid: isPaid,
      deadline: deadline,
      paidDate: paidDate,
      historyChangeReason: historyChangeReason,
      customer: customer,
      transaction: transaction,
    );
  }
}
