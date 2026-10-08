import 'package:cross_file/cross_file.dart';
import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:dio/dio.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/payload/import_products_payload.dart';

final class ImportProductsRequest extends RemoteRequest<ImportProductsPayload> {
  final XFile file;

  ImportProductsRequest.fromPayload(super.payload)
      : file = payload.file,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};

  @override
  Future<FormData> form() async => FormData.fromMap({
        "file": MultipartFile.fromBytes(
          await file.readAsBytes(),
          filename: file.name,
        ),
      });
}
