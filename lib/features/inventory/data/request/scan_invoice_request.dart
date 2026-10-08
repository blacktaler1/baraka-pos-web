import 'package:cross_file/cross_file.dart';
import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;

import '../../domain/payload/scan_invoice_payload.dart';

final class ScanInvoiceRequest extends RemoteRequest<ScanInvoicePayload> {
  final XFile file;

  ScanInvoiceRequest.fromPayload(super.payload)
      : file = payload.file,
        super.fromPayload();

  static const _mediaTypes = {
    ".jpg": "image/jpeg",
    ".jpeg": "image/jpeg",
    ".png": "image/png",
    ".webp": "image/webp",
    ".pdf": "application/pdf",
  };

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};

  @override
  Future<FormData> form() async {
    final type = _mediaTypes[p.extension(file.name).toLowerCase()];
    return FormData.fromMap({
      "file": MultipartFile.fromBytes(
        await file.readAsBytes(),
        filename: file.name,
        contentType: type == null ? null : DioMediaType.parse(type),
      ),
    });
  }
}
