import 'package:baraka_pos/features/debtors/domain/model/customer_model.dart';

import '../../../../shared/domain/domain.dart';

final class CustomerCollection extends Collection<CustomerModel> {
  const CustomerCollection({required super.models});

  @override
  List<String> get props => [
        "collection: $models",
      ];
}
