import 'package:baraka_pos/features/debtors/debtors.dart';

import '../../../../shared/aplication/types/json.dart';
import '../../../../shared/data/data.dart';
import '../../domain/model/customer_model.dart';
import 'customer_dto.dart';

final class CustomerCollectionDto
    extends JsonCollectionDto<CustomerDto, CustomerCollection, CustomerModel> {
  final Json json;

  CustomerCollectionDto.fromJson(this.json)
      : super.fromJson(
          json,
          (e) => CustomerDto.fromJson(e),
        );

  CustomerCollectionDto.fromList(List list)
      : json = {"data": list},
        super.fromJson(
          {"data": list},
          (e) => CustomerDto.fromJson(e),
        );

  @override
  CustomerCollection collection() {
    return CustomerCollection(
      models: items.map((e) => e.model()).toList(),
    );
  }
}
