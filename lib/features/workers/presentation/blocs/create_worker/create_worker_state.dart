part of 'create_worker_bloc.dart';

class CreateWorkerState extends Equatable {
  final String name;
  final String phone;
  final String password;
  final String role;
  final int? id;
  final WorkerPermissions permissions;

  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const CreateWorkerState({
    this.name = '',
    this.phone = '',
    this.password = '',
    this.role = '',
    this.id = 000,
    this.permissions = const WorkerPermissions(),
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  CreateWorkerState copyWith({
    String? name,
    String? phone,
    String? password,
    String? role,
    int? id,
    WorkerPermissions? permissions,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return CreateWorkerState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      role: role ?? this.role,
      id: id ?? this.id,
      permissions: permissions ?? this.permissions,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        name,
        phone,
        password,
        role,
        id,
        permissions,
        isLoading,
        isSuccess,
        errorMessage
      ];
}
