import 'package:baraka_pos/shared/aplication/aplication.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/domain.dart';
import 'cash_shift_collection_dto.dart';

final class GetShiftsDto extends JsonDto<GetShiftsModel> {
  final Json json;

  const GetShiftsDto.fromJson(this.json) : super.fromJson(json);

  @override
  GetShiftsModel model() {
    return GetShiftsModel(
      next: json.text("next"),
      previous: json.text("previous"),
      total: json.integer("total"),
      data: CashShiftCollectionDto.fromList(json.items("data")).collection(),
    );
  }
}
