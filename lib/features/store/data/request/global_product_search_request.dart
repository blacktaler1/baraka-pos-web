import 'package:baraka_pos/features/store/domain/domain.dart';
import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

final class GlobalProductSearchRequest
    extends RemoteRequest<GlobalProductPayload> {
  final String search;
  GlobalProductSearchRequest.fromPayload(super.payload)
      : search = payload.search,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};
  @override
  Map<String, String> query() => {};
}
