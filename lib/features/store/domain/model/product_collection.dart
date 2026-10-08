import 'package:baraka_pos/features/global/domain/domain.dart';
import 'package:baraka_pos/shared/shared.dart';

final class AllProductCollectionModel extends Collection<ProductModel> {
  const AllProductCollectionModel({required super.models});

  @override
  List<String> get props => [
        "models: $models",
      ];
}
