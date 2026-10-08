import '../../../../shared/shared.dart';

final class GlobalProductPayload extends Payload {
  final String search;

  const GlobalProductPayload({required this.search});

  @override
  List<Object> get props => ["search: $search"];
}
