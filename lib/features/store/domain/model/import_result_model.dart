import 'package:baraka_pos/shared/domain/domain.dart';

final class ImportResultModel extends Model {
  final int created;
  final int updated;

  const ImportResultModel({required this.created, required this.updated});

  @override
  List<String> get props => ["created: $created", "updated: $updated"];
}
