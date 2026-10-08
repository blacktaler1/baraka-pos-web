import '../../../../shared/domain/domain.dart';

final class CustomerModel extends Model {
  final int id;
  final String created;
  final String modified;
  final String fullName;
  final String phone;
  final String address;
  final String deletedAt;
  final int warehouse;

  const CustomerModel({
    required this.id,
    required this.created,
    required this.modified,
    required this.fullName,
    required this.phone,
    required this.address,
    required this.deletedAt,
    required this.warehouse,
  });

  @override
  List<String> get props => [
        "id: $id",
        "created: $created",
        "modified: $modified",
        "full_name: $fullName",
        "phone: $phone",
        "address: $address",
        "deleted_at: $deletedAt",
        "warehouse: $warehouse",
      ];
}
