part of '../data.dart';

/// Base class for all DTOs that are created from JSON.
///
/// This class is used to create DTOs from JSON. It is used in the data layer.
/// DTO classes must be implemented as Model contracts in domain layer.
///
/// example:
/// ```dart
/// // auth/domain/models/user_model.dart
/// abstract class UserModel {
///   int get id;
///   String get name;
/// }
///
/// // auth/data/dto/user_dto.dart
/// class UserDto extends JsonDto implements UserModel {
///   @override
///   final int id;
///
///   @override
///   final String name;
///
///   UserDto.fromJson(super.json)
///       : id = json['id'],
///         name = json['name'],
///         super.fromJson();
///
///   @override
///   List<Object> get props => [
///         'id: $id',
///         'name: $name',
///       ];
/// }
/// ```

abstract class JsonDto<M extends Model> {
  const JsonDto.fromJson(Json json);

  M model();
}
