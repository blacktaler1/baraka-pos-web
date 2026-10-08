import 'package:baraka_pos/features/cash/cash.dart';

import '../../../../shared/domain/domain.dart';

final class GetRefundCollection extends Collection<GetRefundModel> {
  const GetRefundCollection({required super.models});
  @override
  List<String> get props => [
        "collection: $models",
      ];
}
