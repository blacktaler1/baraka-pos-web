import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';

import 'share_utils.dart';

const _xlsxMime =
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';

/// Webda "saqlash oynasi" yo'q — fayl ulashiladi yoki yuklab olinadi
Future<String?> saveExcelFile(Uint8List bytes, String fileName) async {
  await shareFileBytes(bytes, fileName, _xlsxMime);
  return fileName;
}

Future<XFile?> pickExcelFile() => pickSingleFile(const ['xlsx']);

/// Brauzerda fayl yo'li bo'lmaydi — baytlar bilan XFile qaytaramiz
Future<XFile?> pickSingleFile(List<String> extensions) async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: extensions,
    withData: true,
  );
  final file = result?.files.single;
  final bytes = file?.bytes;
  if (file == null || bytes == null) return null;
  return XFile.fromData(bytes, name: file.name);
}

Future<XFile?> pickImageFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.image,
    withData: true,
  );
  final file = result?.files.single;
  final bytes = file?.bytes;
  if (file == null || bytes == null) return null;
  return XFile.fromData(bytes, name: file.name);
}
