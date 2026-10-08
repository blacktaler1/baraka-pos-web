import 'package:baraka_pos/shared/domain/domain.dart';

final class LastVersionModel extends Model {
  final int id;
  final String url;
  final String version;
  final String build;
  final String modified;
  final String created;
  final bool isMajor;

  const LastVersionModel({
    required this.id,
    required this.url,
    required this.version,
    required this.build,
    required this.created,
    required this.modified,
    required this.isMajor,
  });

  @override
  List<String> get props => [
        "id: $id",
        "url: $url",
        "version: $version",
        "build: $build",
        "modified: $modified",
        "created: $created",
      ];
}
