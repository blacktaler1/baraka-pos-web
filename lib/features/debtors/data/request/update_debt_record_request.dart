import 'package:baraka_pos/shared/shared.dart';

import '../../domain/payload/update_debt_record_payload.dart';

final class UpdateDebtRecordRequest
    extends RemoteRequest<UpdateDebtRecordPayload> {
  final Json body;

  UpdateDebtRecordRequest.fromPayload(super.payload)
      : body = payload.toJson(),
        super.fromPayload();

  @override
  Json data() => body;

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
