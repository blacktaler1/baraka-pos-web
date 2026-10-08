import 'package:baraka_pos/shared/domain/domain.dart';

final class ChangePasswordModel extends Model {
  final String detail;

  const ChangePasswordModel({required this.detail});

  @override
  List<String> get props => ["detail: $detail"];
}
