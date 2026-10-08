import 'package:bloc/bloc.dart';
import 'package:baraka_pos/features/workers/domain/domain.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';
import '../../../../global/domain/domain.dart';

part 'delete_worker_event.dart';
part 'delete_worker_state.dart';

class DeleteWorkerBloc extends Bloc<DeleteWorkerEvent, DeleteWorkerState> {
  final WorkersRepository repository;
  DeleteWorkerBloc({required this.repository}) : super(DeleteWorkerInitial()) {
    on<DeleteWorkerEvent>(_onDeleteWorkerEvent);
  }

  Future<void> _onDeleteWorkerEvent(
    DeleteWorkerEvent event,
    Emitter<DeleteWorkerState> emit,
  ) async {
    emit(DeleteWorkerInitial());

    emit(DeleteWorkerPrepare());

    final result = await repository.deleteUser(
      payload: DeleteWorkerPayload(id: event.id),
    );

    result.when(
      success: (model) => emit(
        DeleteWorkerSuccess(model: model),
      ),
      failure: (error) => emit(
        DeleteWorkerFailure(error: error),
      ),
    );
  }
}
