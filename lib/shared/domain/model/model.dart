part of '../domain.dart';

/// The base class for all models that should be present in the domain layer.
///
/// all properties should have getters and (maybe) setters.
///
/// example:
/// ```dart
/// abstract class User extends Model {
///   int get id;
///   String get name;
/// }
/// ```
abstract class Model extends Equatable {
  const Model();

  /// stringable `key: value` pairs of the model.
  ///
  /// required for testing and determining changeble properties.
  ///
  /// ui layer can rebuild widget tree if [props] changed.
  @override
  List<String> get props;
}
