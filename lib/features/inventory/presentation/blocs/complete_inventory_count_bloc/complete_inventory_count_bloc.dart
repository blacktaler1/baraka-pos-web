import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/domain.dart';

part 'complete_inventory_count_event.dart';
part 'complete_inventory_count_state.dart';

class CompleteInventoryCountBloc
    extends Bloc<CompleteInventoryCountEvent, CompleteInventoryCountState> {
  final InventoryRepository repository;

  CompleteInventoryCountBloc({required this.repository})
      : super(CompleteInventoryCountInitial()) {
    on<CompleteInventoryCountStarted>(_onCompleteInventoryCountStarted);
  }

  Future<void> _onCompleteInventoryCountStarted(
    CompleteInventoryCountStarted event,
    Emitter<CompleteInventoryCountState> emit,
  ) async {
    emit(CompleteInventoryCountPrepare());

    final result = await repository.completeInventoryCount(
      payload: CompleteInventoryCountPayload(
        id: event.id,
      ),
    );

    result.when(
      success: (model) => emit(CompleteInventoryCountSuccess(model: model)),
      failure: (error) => emit(CompleteInventoryCountFailure(error: error)),
    );
  }
}
