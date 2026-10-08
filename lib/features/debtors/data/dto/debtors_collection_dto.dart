import 'package:baraka_pos/features/debtors/debtors.dart';
import 'package:baraka_pos/shared/shared.dart';

final class DebtorsCollectionDto extends JsonCollectionDto<DebtorsItemDto,
    DebtorsDataCollection, DebtorsItemModel> {
  final Json json;

  DebtorsCollectionDto.fromJson(this.json)
      : super.fromJson(
          json,
          (e) => DebtorsItemDto.fromJson(e),
        );
  DebtorsCollectionDto.fromList(List list)
      : json = {"data": list},
        super.fromJson(
          {"data": list},
          (e) => DebtorsItemDto.fromJson(e),
        );

  @override
  DebtorsDataCollection collection() {
    return DebtorsDataCollection(
      models: items.map((e) => e.model()).toList(),
    );
  }
}
