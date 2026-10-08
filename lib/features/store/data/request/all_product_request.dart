import 'package:baraka_pos/features/store/domain/domain.dart';
import 'package:baraka_pos/shared/shared.dart';

final class AllProductRequest extends RemoteRequest<GetAllProductPayload> {
  final String search;
  final String category;
  final String cursor;
  final int pageSize;
  final int firmaId;
  final bool? lowStock;

  AllProductRequest.fromPayload(super.payload)
      : search = payload.search,
        category = payload.category,
        cursor = payload.cursor,
        pageSize = payload.pageSize,
        firmaId = payload.firmaId,
        lowStock = payload.lowStrock,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {
        if (search.isNotEmpty) 'search': search,
        if (category.isNotEmpty) 'category': category,
        if (cursor.isNotEmpty) 'cursor': cursor,
        if (pageSize > 0) 'page_size': pageSize.toString(),
        if (firmaId > 0) 'firma_id': firmaId.toString(),
        if (lowStock != null) 'low_stock': lowStock.toString(),
      };
}
