import 'package:baraka_pos/features/debtors/debtors.dart';
import '../../../../shared/shared.dart';

final class ByCustomerCollectionDto extends JsonCollectionDto<ByCustomerItemDto,
    ByCustomerDebtCollection, ByCustomerItemModel> {
  final Json json;

  ByCustomerCollectionDto.fromJson(this.json)
      : super.fromJson(
          json,
          (e) => ByCustomerItemDto.fromJson(e),
        );
  ByCustomerCollectionDto.fromList(List list)
      : json = {"data": list},
        super.fromJson(
          {"data": list},
          (e) => ByCustomerItemDto.fromJson(e),
        );

  @override
  ByCustomerDebtCollection collection() {
    return ByCustomerDebtCollection(
      models: items.map((e) => e.model()).toList(),
    );
  }
}
