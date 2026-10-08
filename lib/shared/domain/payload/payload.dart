part of '../domain.dart';

/// Base class for all payloads that are used to pass data between presentation
/// and data layers.
///
/// Payloads must be realized as immutable classes with final fields in domain
/// layer.
///
/// example:
/// ```dart
/// class LoginPayload extends Payload {
///
///   final String email;
///   final String password;
///
///   const LoginPayload({
///     required this.email,
///     required this.password,
///   });
///
///   @override
///   List<Object> get props => [
///     'email: $email',
///     'password: $password',
///   ];
/// }
/// ```
///
/// usage:
/// ```dart
/// final payload = LoginPayload(email: 'email', password: 'password');
/// repository.login(payload: payload);
/// ```
abstract class Payload extends Equatable {
  const Payload();
  @override
  List<Object> get props;
}
