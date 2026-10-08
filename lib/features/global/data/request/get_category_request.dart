import 'package:baraka_pos/features/global/global.dart';
import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

final class GetCategoryRequest extends RemoteRequest<CategoryPayload> {
  final String cursor;
  final String pageSize;

  GetCategoryRequest.fromPayload(super.payload)
      : cursor = payload.cursor,
        pageSize = payload.pageSize,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {
        "cursor": cursor,
        "page_size": pageSize.toString(),
      };
}
