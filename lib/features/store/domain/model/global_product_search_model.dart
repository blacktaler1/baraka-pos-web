import 'package:baraka_pos/features/store/domain/domain.dart';

import '../../../../shared/shared.dart';

final class GlobalProductSearchModel extends Model {
  final String next;
  final String previous;
  final GlobalProductCollection result;

  const GlobalProductSearchModel({
    required this.next,
    required this.previous,
    required this.result,
  });

  @override
  List<String> get props => [
        "next: $next",
        "previus: $previous",
        "result: $result",
      ];
}
