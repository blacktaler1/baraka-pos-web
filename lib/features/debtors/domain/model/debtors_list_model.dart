import 'package:baraka_pos/features/debtors/domain/model/debtors_data_collection.dart';
import 'package:baraka_pos/shared/domain/domain.dart';

final class DebtorsListModel extends Model {
  final String next;
  final String previus;
  final int total;
  final DebtorsDataCollection data;

  const DebtorsListModel({
    required this.next,
    required this.previus,
    required this.total,
    required this.data,
  });

  @override
  List<String> get props => [
        "next: $next",
        "previus: $previus",
        "total: $total",
        "data: $data",
      ];
}
