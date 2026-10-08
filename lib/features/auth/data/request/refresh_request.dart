import 'package:baraka_pos/features/auth/auth.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';

final class RefreshRequest extends RemoteRequest<RefreshPayload> {
  final String refresh;

  RefreshRequest.fromPayload(super.payload)
      : refresh = payload.refresh,
        super.fromPayload();

  @override
  Json data() => {
        "refresh": refresh,
      };

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
