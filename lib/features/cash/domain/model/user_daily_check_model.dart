import '../../../../shared/shared.dart';

final class UserDailyCheckModel extends Model {
  final int id;
  final String name;

  const UserDailyCheckModel({
    required this.id,
    required this.name,
  });

  @override
  List<String> get props => [
        "id: $id",
        "name: $name",
      ];
}
