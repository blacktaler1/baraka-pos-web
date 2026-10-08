import '../../../../shared/domain/domain.dart';
import 'inventory_item_model.dart';

final class InventoryItemCollection extends Collection<InventoryItemModel> {
  const InventoryItemCollection({required super.models});

  @override
  List<String> get props => [
        "collection: $models",
      ];
}
