part of 'update_worker_bloc.dart';

abstract class UpdateUserEvent extends Equatable {
  const UpdateUserEvent();

  @override
  List<Object?> get props => [];
}

class UpdateUserStarted extends UpdateUserEvent {
  final UpdateWorkerPayload payload;

  const UpdateUserStarted({required this.payload});

  @override
  List<Object?> get props => [payload];
}
