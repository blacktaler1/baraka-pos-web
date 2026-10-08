part of 'change_pass_bloc.dart';

final class ChangePassEvent extends Equatable {
  final String oldPassword;
  final String newPassword;
  const ChangePassEvent({
    required this.newPassword,
    required this.oldPassword,
  });

  @override
  List<Object> get props => [
        "oldPas: $oldPassword",
        "newPass: $newPassword",
      ];
}
