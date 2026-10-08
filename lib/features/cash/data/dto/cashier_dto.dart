import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';
import '../../domain/model/cashier_model.dart';

final class CashierDto extends JsonDto<CashierModel> {
  final Json json;

  const CashierDto.fromJson(this.json) : super.fromJson(json);

  int get id => json.integer("id");

  String get name => json.text("name");

  @override
  CashierModel model() {
    return CashierModel(
      id: id,
      name: name,
    );
  }
}
