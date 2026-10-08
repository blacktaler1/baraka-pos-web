import 'package:baraka_pos/shared/domain/domain.dart';

import 'by_customer_item_debt_model.dart';

final class ByCustomerModel extends Model {
  final ByCustomerDebtCollection debtCollection;

  const ByCustomerModel({required this.debtCollection});

  @override
  List<String> get props => ["collection: $debtCollection"];
}

final class ByCustomerDebtCollection extends Collection<ByCustomerItemModel> {
  const ByCustomerDebtCollection({required super.models});
}
