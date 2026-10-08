part of '../domain.dart';

/// Base class for all collections that should be present in the domain layer.
///
/// Collections indicates item type via generic type [M].
///
/// example:
/// ```dart
/// abstract class UserCollection extends Collection<User> {
/// }
/// ```
/// usage:
/// ```dart
/// final UserCollection users = UserCollectionImpl();
/// print(users.items);
/// ```
abstract class Collection<M extends Model> extends Model {
  const Collection({required this.models});

  /// List of items in the collection.
  final List<M> models;

  @override
  List<String> get props => [
        'models: $models',
      ];
}
