import 'package:baraka_pos/features/expenses/domain/domain.dart';
import 'package:baraka_pos/shared/aplication/aplication.dart';
import 'package:baraka_pos/shared/data/data.dart';

final class ExpenseDto extends JsonDto<ExpenseModel> {
  final Json json;

  const ExpenseDto.fromJson(this.json) : super.fromJson(json);

  int get id => json.integer("id");
  String get created => json.text("created");
  String get modified => json.text("modified");
  String get title => json.text("title");
  String get amount => json.text("amount", fallback: "0");
  int get warehouse => json.integer("warehouse");

  @override
  ExpenseModel model() {
    return ExpenseModel(
      id: id,
      created: created,
      modified: modified,
      title: title,
      amount: amount,
      warehouse: warehouse,
    );
  }
}
