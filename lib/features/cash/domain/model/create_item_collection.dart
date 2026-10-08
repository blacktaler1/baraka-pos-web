import '../../../../shared/domain/domain.dart';
import 'create_item_model.dart';

final class CreateItemCollection extends Collection<CreateItemModel> {
  const CreateItemCollection({required super.models});

  @override
  List<String> get props => [
        "collection: $models",
      ];
}
