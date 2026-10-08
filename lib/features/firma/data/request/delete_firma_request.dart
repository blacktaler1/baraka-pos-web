import 'package:baraka_pos/features/firma/domain/payload/delete_firma_payload.dart';
import 'package:baraka_pos/shared/shared.dart';

final class DeleteFirmaRequest extends RemoteRequest<DeleteFirmaPayload> {
  final int id;

  DeleteFirmaRequest.fromPayload(super.payload)
      : id = payload.id,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
