import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/payload/export_products_payload.dart';

final class ExportProductsRequest extends RemoteRequest<ExportProductsPayload> {
  ExportProductsRequest.fromPayload(super.payload) : super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
