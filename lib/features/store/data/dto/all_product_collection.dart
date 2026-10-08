import 'package:baraka_pos/features/global/domain/domain.dart';
import 'package:baraka_pos/features/store/data/data.dart';
import 'package:baraka_pos/features/store/domain/model/product_collection.dart';
import 'package:baraka_pos/shared/shared.dart';

final class AllProductCollectionDto extends JsonCollectionDto<ProductDto,
    AllProductCollectionModel, ProductModel> {
  final Json json;

  AllProductCollectionDto.fromJson(this.json)
      : super.fromJson(json, (e) => ProductDto.fromJson(e));

  AllProductCollectionDto.fromList(List list)
      : json = {"data": list},
        super.fromJson(
          {"data": list},
          (e) => ProductDto.fromJson(e),
        );
  @override
  AllProductCollectionModel collection() {
    return AllProductCollectionModel(
      models: items.map((e) => e.model()).toList(),
    );
  }
}
