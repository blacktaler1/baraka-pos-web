import 'package:baraka_pos/features/debtors/domain/payload/get_debtors_payload.dart';
import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

final class GetDebtorsRequest extends RemoteRequest<GetDebtorsPayload> {
  final bool? hasDebt;
  final bool? nearingDeadline;
  final String? search;
  final String? ordering;
  final String? pageSize;

  GetDebtorsRequest.fromPayload(super.payload)
      : hasDebt = payload.hasDebt,
        nearingDeadline = payload.nearingDeadline,
        search = payload.search,
        ordering = payload.ordering,
        pageSize = payload.pageSize,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() {
    final Map<String, String> query = {};

    if (hasDebt != null) {
      query['has_debt'] = hasDebt.toString();
    }

    if (nearingDeadline != null) {
      query['nearing_deadline'] = nearingDeadline.toString();
    }

    if (search != null && search!.isNotEmpty) {
      query['search'] = search!;
    }

    if (ordering != null && ordering!.isNotEmpty) {
      query['ordering'] = ordering!;
    }

    if (pageSize != null && pageSize!.isNotEmpty) {
      query['page_size'] = pageSize!;
    }

    return query;
  }
}
