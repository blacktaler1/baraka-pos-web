part of '../domain.dart';

/// A collection of models that can be paginated and should be present in the
/// domain layer.
///
/// This class is used to represent a paginated collection of models.
/// It extends [Collection] and adds the following properties:
/// - [total]: the total number of items in the collection.
/// - [hasMore]: a boolean indicating if there are more items to fetch.
///
/// example:
/// ```dart
/// abstract class UserPaginatedCollection extends PaginatedCollection<UserModel> {
/// }
/// ```
///
/// usage:
/// ```dart
/// final UserPaginatedCollection users = UserPaginatedCollectionImpl();
/// print(users.items);
/// print(users.offset);
/// print(users.limit);
/// print(users.total);
/// print(users.hasMore);
/// ```

abstract class PaginatedCollection<M extends Model> extends Collection<M> {
  final int total;

  final bool hasMore;

  const PaginatedCollection({
    required super.models,
    required this.total,
    required this.hasMore,
  }) : super();

  @override
  List<String> get props => [
        ...super.props,
        'total: $total',
        'hasMore: $hasMore',
      ];
}
