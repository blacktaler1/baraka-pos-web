import 'package:baraka_pos/features/firma/domain/domain.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';

final class GetByIdFirmaRequest extends RemoteRequest<GetByIdFirmaPayload> {
  final int id;

  GetByIdFirmaRequest.fromPayload(super.payload)
      : id = payload.id,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {"id": id.toString()};

  @override
  Map<String, String> query() => {};
}
