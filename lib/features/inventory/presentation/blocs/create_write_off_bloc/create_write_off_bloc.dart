import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/domain.dart';

part 'create_write_off_event.dart';
part 'create_write_off_state.dart';

class CreateWriteOffBloc
    extends Bloc<CreateWriteOffEvent, CreateWriteOffState> {
  final InventoryRepository repository;

  CreateWriteOffBloc({required this.repository})
      : super(CreateWriteOffInitial()) {
    on<CreateWriteOffStarted>(_onCreateWriteOffStarted);
  }

  Future<void> _onCreateWriteOffStarted(
    CreateWriteOffStarted event,
    Emitter<CreateWriteOffState> emit,
  ) async {
    emit(CreateWriteOffPrepare());

    final result = await repository.createWriteOff(
      payload: CreateWriteOffPayload(
        reason: event.reason,
        note: event.note,
        items: event.items,
      ),
    );

    result.when(
      success: (model) => emit(CreateWriteOffSuccess(model: model)),
      failure: (error) => emit(CreateWriteOffFailure(error: error)),
    );
  }
}
