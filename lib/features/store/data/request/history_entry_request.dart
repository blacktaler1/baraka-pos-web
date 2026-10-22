import 'package:baraka_pos/shared/aplication/types/json.dart';

import '../../../../shared/data/data.dart';
import '../../domain/payload/history_entry_payload.dart';

final class HistoryEntryRequest extends RemoteRequest<HistoryEntryPayload> {
  final int pk;
  final int entryId;
  final Json body;

  HistoryEntryRequest.fromPayload(super.payload)
      : pk = payload.pk,
        entryId = payload.entryId,
        body = payload.toJson(),
        super.fromPayload();

  @override
  Json data() => body;

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
