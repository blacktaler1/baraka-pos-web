part of '../data.dart';

/// DTO for paginated collections.
///
/// This class is used to parse paginated collections from JSON.
///

abstract class JsonPaginatedCollectionDto<
    D extends JsonDto<M>,
    C extends Collection<M>,
    M extends Model> extends JsonCollectionDto<D, C, M> {
  final int offset;

  final int limit;

  final int total;

  final bool hasMore;

  JsonPaginatedCollectionDto.fromJson(
    super.json,
    super.factory,
  )   : offset = json['offset'] ?? 0,
        limit = json['limit'] ?? 0,
        total = json['total'] ?? 0,
        hasMore = json['has_more'] ?? false,
        super.fromJson();
}
