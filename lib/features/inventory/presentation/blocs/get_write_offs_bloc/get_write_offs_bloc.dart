import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/domain.dart';

part 'get_write_offs_event.dart';
part 'get_write_offs_state.dart';

class GetWriteOffsBloc extends Bloc<GetWriteOffsEvent, GetWriteOffsState> {
  final InventoryRepository repository;

  GetWriteOffsBloc({required this.repository}) : super(GetWriteOffsInitial()) {
    on<GetWriteOffsStarted>(_onGetWriteOffsStarted);
  }

  Future<void> _onGetWriteOffsStarted(
    GetWriteOffsStarted event,
    Emitter<GetWriteOffsState> emit,
  ) async {
    emit(GetWriteOffsPrepare());

    final result = await repository.getWriteOffs(
      payload: GetWriteOffsPayload(
        cursor: event.cursor,
        pageSize: event.pageSize,
      ),
    );

    result.when(
      success: (model) => emit(GetWriteOffsSuccess(model: model)),
      failure: (error) => emit(GetWriteOffsFailure(error: error)),
    );
  }
}
