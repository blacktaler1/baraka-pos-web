import 'package:baraka_pos/shared/domain/domain.dart';

final class RefreshPayload extends Payload {
  final String refresh;

  const RefreshPayload({
    required this.refresh,
  });

  @override
  List<Object> get props => ['refresh: $refresh'];
}
