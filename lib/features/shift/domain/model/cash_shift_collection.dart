import '../../../../shared/domain/domain.dart';
import 'cash_shift_model.dart';

final class CashShiftCollection extends Collection<CashShiftModel> {
  const CashShiftCollection({required super.models});

  @override
  List<String> get props => [
        "collection: $models",
      ];
}
