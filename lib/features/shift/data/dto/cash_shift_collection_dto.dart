import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/domain.dart';
import 'cash_shift_dto.dart';

final class CashShiftCollectionDto extends JsonCollectionDto<CashShiftDto,
    CashShiftCollection, CashShiftModel> {
  final Json json;

  CashShiftCollectionDto.fromList(List<dynamic> list)
      : json = {"data": list},
        super.fromJson({"data": list}, (e) => CashShiftDto.fromJson(e));

  @override
  CashShiftCollection collection() {
    return CashShiftCollection(models: items.map((e) => e.model()).toList());
  }
}
