part of '../data.dart';

/// A collection of JSON objects.
///
/// This class is used to parse JSON objects into [Collection] that are
/// returned from the API.
///
///
abstract class JsonCollectionDto<D extends JsonDto, C extends Collection<M>,
    M extends Model> {
  final List<D> items;

  C collection();

  JsonCollectionDto.fromJson(
    Json json,
    D Function(Json json) factory,
  ) : items = switch (json['data']) {
          List list => list.map((json) => factory(json)).toList(),
          _ => [],
        };
}
