part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class LoginStarted extends LoginEvent {
  final String phoneNumber;
  final String code;
  final String password;

  const LoginStarted({
    required this.phoneNumber,
    required this.code,
    required this.password,
  });

  @override
  List<Object> get props => [
        "code: $code",
        "phone: $phoneNumber",
        "password: $password",
      ];
}
