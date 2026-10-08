import 'package:baraka_pos/features/firma/domain/domain.dart';
import 'package:baraka_pos/shared/domain/domain.dart';

final class LoanFirmaCollection extends Collection<LoanFirmaModel> {
  const LoanFirmaCollection({required super.models});
  @override
  List<String> get props => [
        "collection: $models",
      ];
}
