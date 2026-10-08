import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/domain.dart';

part 'create_inventory_count_event.dart';
part 'create_inventory_count_state.dart';

class CreateInventoryCountBloc
    extends Bloc<CreateInventoryCountEvent, CreateInventoryCountState> {
  final InventoryRepository repository;

  CreateInventoryCountBloc({required this.repository})
      : super(CreateInventoryCountInitial()) {
    on<CreateInventoryCountStarted>(_onCreateInventoryCountStarted);
  }

  Future<void> _onCreateInventoryCountStarted(
    CreateInventoryCountStarted event,
    Emitter<CreateInventoryCountState> emit,
  ) async {
    emit(CreateInventoryCountPrepare());

    final result = await repository.createInventoryCount(
      payload: CreateInventoryCountPayload(
        note: event.note,
      ),
    );

    result.when(
      success: (model) => emit(CreateInventoryCountSuccess(model: model)),
      failure: (error) => emit(CreateInventoryCountFailure(error: error)),
    );
  }
}
