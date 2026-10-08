import '../../../../shared/domain/domain.dart';
import 'inventory_count_model.dart';

final class InventoryCountCollection extends Collection<InventoryCountModel> {
  const InventoryCountCollection({required super.models});

  @override
  List<String> get props => [
        "collection: $models",
      ];
}
