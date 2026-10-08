import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/payload/export_debtors_payload.dart';

final class ExportDebtorsRequest extends RemoteRequest<ExportDebtorsPayload> {
  ExportDebtorsRequest.fromPayload(super.payload) : super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
