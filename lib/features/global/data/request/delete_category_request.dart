import 'package:baraka_pos/features/global/domain/domain.dart';
import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

final class DeleteCategoryRequest extends RemoteRequest<DeleteCategoryPayload> {
  final int pk;

  DeleteCategoryRequest.fromPayload(super.payload)
      : pk = payload.pk,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
