import 'package:baraka_pos/features/debtors/domain/domain.dart';
import 'package:baraka_pos/shared/domain/domain.dart';

final class AllCustomerHistoryModel extends Model {
  final ByCustomerHistoryCollection data;

  const AllCustomerHistoryModel({
    required this.data,
  });

  @override
  List<String> get props => [
        "data:$data",
      ];
}
