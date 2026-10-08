part of 'create_product_bloc.dart';

sealed class CreateProductEvent extends Equatable {
  const CreateProductEvent();

  @override
  List<Object> get props => [];
}

final class CreateProductStarted extends CreateProductEvent {
  final String title;
  final int cost;
  final int price;
  final double stock;
  final int categoryId;
  final String unit;
  final int packSize;
  final List imagesIds;
  final String qrCode;
  final int firmaId;
  final int? wholesalePrice;
  final double? minStock;
  const CreateProductStarted({
    required this.title,
    required this.cost,
    required this.price,
    required this.stock,
    required this.categoryId,
    required this.unit,
    required this.packSize,
    required this.imagesIds,
    required this.qrCode,
    required this.firmaId,
    this.wholesalePrice,
    this.minStock,
  });

  @override
  List<Object> get props => [
        "title: $title",
        "cost: $cost",
        "price: $price",
        "stock: $stock",
        "categoryId: $categoryId",
        "unit: $unit",
        "imagesIds: $imagesIds",
        "qrCode: $qrCode",
        "firmaId: $firmaId",
        "wholesale_price: $wholesalePrice",
        "min_stock: $minStock",
      ];
}
