import 'package:baraka_pos/features/auth/auth.dart';
import 'package:baraka_pos/shared/domain/domain.dart';

final class FirmaModel extends Model {
  final int id;
  final String title;
  final String phone;
  final String address;
  final int warehouse;
  final ImageCollection images;
  final String created;
  final String modified;
  final String deletedAt;
  final int totalProducts;
  final num totalDebt;
  final num totalPaid;
  final num remainder;

  const FirmaModel({
    required this.id,
    required this.title,
    required this.warehouse,
    required this.phone,
    required this.address,
    required this.images,
    required this.created,
    required this.modified,
    required this.deletedAt,
    required this.totalProducts,
    required this.totalDebt,
    required this.totalPaid,
    required this.remainder,
  });

  @override
  List<String> get props => [
        "id: $id",
        "title: $title",
        "warehouse: $warehouse",
        "phone: $phone",
        "address: $address",
        "images: $images",
        "created: $created",
        "modified: $modified",
        "deletedAt: $deletedAt",
        "total_products: $totalProducts",
        "total_debt: $totalDebt",
        "total_paid: $totalPaid",
        "remainder: $remainder",
      ];
}
