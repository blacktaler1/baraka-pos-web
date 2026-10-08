import 'package:baraka_pos/features/firma/domain/domain.dart';
import 'package:baraka_pos/shared/domain/domain.dart';

final class FirmaCollection extends Collection<FirmaModel> {
  const FirmaCollection({required super.models});
  @override
  List<String> get props => [
        "collection: $models",
      ];
}
