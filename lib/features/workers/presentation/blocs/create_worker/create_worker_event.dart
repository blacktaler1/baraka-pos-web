part of 'create_worker_bloc.dart';

abstract class CreateWorkerEvent extends Equatable {
  const CreateWorkerEvent();

  @override
  List<Object?> get props => [];
}

/// form fields
class CreateWorkerNameChanged extends CreateWorkerEvent {
  final String name;
  const CreateWorkerNameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class CreateWorkerPhoneChanged extends CreateWorkerEvent {
  final String phone;
  const CreateWorkerPhoneChanged(this.phone);

  @override
  List<Object?> get props => [phone];
}

class CreateWorkerPasswordChanged extends CreateWorkerEvent {
  final String password;
  const CreateWorkerPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class CreateWorkerRoleChanged extends CreateWorkerEvent {
  final String role;
  const CreateWorkerRoleChanged(this.role);

  @override
  List<Object?> get props => [role];
}

class CreateWorkerImageChanged extends CreateWorkerEvent {
  final int? id;
  const CreateWorkerImageChanged(this.id);

  @override
  List<Object?> get props => ["id: $id"];
}

class CreateWorkerPermissionsChanged extends CreateWorkerEvent {
  final WorkerPermissions permissions;
  const CreateWorkerPermissionsChanged(this.permissions);

  @override
  List<Object?> get props => [permissions];
}

/// Submit
class CreateWorkerStarted extends CreateWorkerEvent {}

class CreateWorkerReset extends CreateWorkerEvent {}
