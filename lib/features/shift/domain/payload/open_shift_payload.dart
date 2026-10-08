import 'package:baraka_pos/shared/domain/domain.dart';

final class OpenShiftPayload extends Payload {
  final int openingCash;

  const OpenShiftPayload({
    required this.openingCash,
  });

  @override
  List<String> get props => [
        "openingCash: $openingCash",
      ];
}
