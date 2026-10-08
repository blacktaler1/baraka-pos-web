import 'package:baraka_pos/shared/domain/domain.dart';

final class CashierModel extends Model {
  final int id;
  final String name;

  const CashierModel({
    required this.id,
    required this.name,
  });

  @override
  List<String> get props => [
        "id: $id",
        "name: $name",
      ];
}
