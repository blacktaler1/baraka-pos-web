import 'package:baraka_pos/shared/aplication/aplication.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/domain.dart';
import 'cash_shift_dto.dart';

final class CurrentShiftDto extends JsonDto<CurrentShiftModel> {
  final Json json;

  const CurrentShiftDto.fromJson(this.json) : super.fromJson(json);

  @override
  CurrentShiftModel model() {
    final shift = json["shift"];
    return CurrentShiftModel(
      shift: shift is Json ? CashShiftDto.fromJson(shift).model() : null,
    );
  }
}
