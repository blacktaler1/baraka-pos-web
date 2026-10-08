import 'package:baraka_pos/shared/domain/domain.dart';

final class DebtorsItemModel extends Model {
  final int id;
  final String name;
  final String phone;
  final String address;
  final String totalDebt;
  final int unPaidRecordsCount;
  final String oldestUnPaidDeadline;

  const DebtorsItemModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.totalDebt,
    required this.unPaidRecordsCount,
    required this.oldestUnPaidDeadline,
  });

  @override
  List<String> get props => [
        "id: $id",
        "name: $name",
        "phone: $phone",
        "address: $address",
        "totalDebt: $totalDebt",
        "unPaidRecordsCount: $unPaidRecordsCount",
        "oldestUnPaidDeadline: $oldestUnPaidDeadline",
      ];
}
