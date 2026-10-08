import 'package:baraka_pos/features/debtors/domain/model/debtors_item_model.dart';
import 'package:baraka_pos/shared/shared.dart';

final class DebtorsItemDto extends JsonDto<DebtorsItemModel> {
  final Json json;

  DebtorsItemDto.fromJson(this.json) : super.fromJson(json);

  int get id => json.integer("id");

  String get name => json.text("full_name");

  String get phone => json.text("phone");

  String get address => json.text("address");

  String get totalDebt => json.text("total_debt", fallback: "0");

  int get unpaidRecordsCount => json.integer("unpaid_records_count");

  String get oldestUnPaidDeadline => json.text("oldest_unpaid_deadline");

  @override
  DebtorsItemModel model() {
    return DebtorsItemModel(
        id: id,
        name: name,
        phone: phone,
        address: address,
        totalDebt: totalDebt,
        unPaidRecordsCount: unpaidRecordsCount,
        oldestUnPaidDeadline: oldestUnPaidDeadline);
  }
}
