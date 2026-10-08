import 'dart:typed_data';

import 'package:baraka_pos/shared/shared.dart';

final class FileBytesModel extends Model {
  final Uint8List bytes;

  const FileBytesModel({required this.bytes});

  @override
  List<String> get props => ["bytes: ${bytes.length}"];
}
