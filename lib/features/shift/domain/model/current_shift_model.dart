import 'package:baraka_pos/shared/domain/domain.dart';

import 'cash_shift_model.dart';

final class CurrentShiftModel extends Model {
  final CashShiftModel? shift;

  const CurrentShiftModel({required this.shift});

  @override
  List<String> get props => ["shift: $shift"];
}
