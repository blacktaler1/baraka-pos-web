import 'package:baraka_pos/features/debtors/domain/model/customer_model.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';

final class CustomerDto extends JsonDto<CustomerModel> {
  final Json json;

  CustomerDto.fromJson(this.json) : super.fromJson(json);

  int get id => json.integer("id");

  String get created => json.text("created");

  String get modified => json.text("modified");

  String get fullName => json.text("full_name");

  String get phone => json.text("phone");

  String get address => json.text("address");

  String get deletedAt => json.text("deleted_at");

  int get warehouse => json.integer("warehouse");

  @override
  CustomerModel model() {
    return CustomerModel(
      id: id,
      created: created,
      modified: modified,
      fullName: fullName,
      phone: phone,
      address: address,
      deletedAt: deletedAt,
      warehouse: warehouse,
    );
  }
}
