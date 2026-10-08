import 'package:baraka_pos/features/auth/auth.dart';
import 'package:baraka_pos/features/firma/data/data.dart';
import 'package:baraka_pos/features/global/global.dart';
import 'package:baraka_pos/shared/shared.dart';

final class ProductDto extends JsonDto<ProductModel> {
  final Json json;

  ProductDto.fromJson(this.json) : super.fromJson(json);

  int get id => json.integer("id");

  String get title => json["title"]?.toString() ?? "";

  String get cost => json["cost"]?.toString() ?? "0";

  String get price => json["price"]?.toString() ?? "0";

  String get wholesalePrice => json.text("wholesale_price");

  String get minStock => json.text("min_stock");

  num get margin => json.number("margin");

  String get stock => parseAmount(json["stock"]?.toString()).toString();

  CategoryDto get categegory => CategoryDto.fromJson(json["category"] ?? {});

  int get packSize => json.integer("pack_size");

  String get unit => json["unit"]?.toString() ?? "";

  ImageCollectionDto get images =>
      ImageCollectionDto.fromList(json["images"] ?? []);

  String get qrCode => json["qr_code"]?.toString() ?? "";

  int get warehouse => json.integer("warehouse");

  FirmaDto? get firma {
    final data = json["firma"];
    if (data == null) return null;
    return FirmaDto.fromJson(data);
  }

  @override
  ProductModel model() {
    return ProductModel(
      id: id,
      title: title,
      cost: cost,
      price: price,
      wholesalePrice: wholesalePrice,
      margin: margin,
      stock: stock,
      minStock: minStock,
      category: categegory.model(),
      packSize: packSize,
      unit: unit,
      qrCode: qrCode,
      imageCollection: images.collection(),
      firma: firma?.model(),
      warehouseId: warehouse,
    );
  }
}
