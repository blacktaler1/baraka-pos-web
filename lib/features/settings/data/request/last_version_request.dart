import 'package:baraka_pos/features/settings/domain/domain.dart';
import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

final class LastVersionRequest extends RemoteRequest<LastVersionPayload> {
  LastVersionRequest.fromPayload(super.payload) : super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
