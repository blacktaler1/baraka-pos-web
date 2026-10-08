import 'package:bloc/bloc.dart';
import 'package:baraka_pos/features/workers/domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'create_worker_event.dart';
part 'create_worker_state.dart';

class CreateWorkerBloc extends Bloc<CreateWorkerEvent, CreateWorkerState> {
  final WorkersRepository repository;

  CreateWorkerBloc({required this.repository})
      : super(const CreateWorkerState()) {
    on<CreateWorkerNameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<CreateWorkerPhoneChanged>((event, emit) {
      emit(state.copyWith(phone: event.phone));
    });

    on<CreateWorkerPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<CreateWorkerRoleChanged>((event, emit) {
      emit(state.copyWith(role: event.role.toLowerCase()));
    });

    on<CreateWorkerImageChanged>((event, emit) {
      emit(state.copyWith(id: event.id));
    });

    on<CreateWorkerPermissionsChanged>((event, emit) {
      emit(state.copyWith(permissions: event.permissions));
    });

    on<CreateWorkerStarted>(_onCreateWorkerStarted);

    on<CreateWorkerReset>((event, emit) {
      emit(const CreateWorkerState());
    });
  }

  Future<void> _onCreateWorkerStarted(
    CreateWorkerStarted event,
    Emitter<CreateWorkerState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));

    final result = await repository.createUser(
      payload: CreateWorkerPayload(
        name: state.name,
        phone: state.phone,
        role: state.role,
        password: state.password,
        image: state.id != null ? [state.id] : [],
        permissions: state.permissions,
      ),
    );

    result.when(
      success: (success) => emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
        ),
      ),
      failure: (failure) => emit(
        state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        ),
      ),
    );
  }
}
