import '../../../../shared/domain/domain.dart';
import 'by_customer_history_model.dart';

final class ByCustomerHistoryCollection
    extends Collection<ByCustomerHistoryModel> {
  const ByCustomerHistoryCollection({required super.models});

  @override
  List<String> get props => [
        "collection: $models",
      ];
}
