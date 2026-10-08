import 'package:bloc/bloc.dart';
import 'package:baraka_pos/features/workers/domain/domain.dart';
import 'package:baraka_pos/shared/shared.dart';
import 'package:equatable/equatable.dart';

part 'get_worker_list_event.dart';
part 'get_worker_list_state.dart';

class GetWorkerListBloc extends Bloc<GetWorkerListEvent, GetWorkerListState> {
  final WorkersRepository repository;
  GetWorkerListBloc({required this.repository})
      : super(GetWorkerListInitial()) {
    on<GetWorkerListStarted>(_onGetWorkerListStarted);
  }

  Future<void> _onGetWorkerListStarted(
    GetWorkerListStarted event,
    Emitter<GetWorkerListState> emit,
  ) async {
    emit(GetWorkerListInitial());

    emit(GetWorkerListPrepare());

    final result = await repository.getWorkers(
      payload: GetWorkersListPayload(),
    );

    result.when(
      success: (model) => emit(
        GetWorkerListSuccess(model: model),
      ),
      failure: (error) => emit(
        GetWorkerListFailure(error: error),
      ),
    );
  }
}
