import 'package:baraka_pos/shared/domain/domain.dart';

import 'cash_product_model.dart';

final class CashProductCollection extends Collection<CashProductModel> {
  const CashProductCollection({required super.models});
  @override
  List<String> get props => [
        "collection: $models",
      ];
}
