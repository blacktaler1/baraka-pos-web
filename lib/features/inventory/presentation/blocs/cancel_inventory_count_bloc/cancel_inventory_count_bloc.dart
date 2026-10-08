import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/domain.dart';

part 'cancel_inventory_count_event.dart';
part 'cancel_inventory_count_state.dart';

class CancelInventoryCountBloc
    extends Bloc<CancelInventoryCountEvent, CancelInventoryCountState> {
  final InventoryRepository repository;

  CancelInventoryCountBloc({required this.repository})
      : super(CancelInventoryCountInitial()) {
    on<CancelInventoryCountStarted>(_onCancelInventoryCountStarted);
  }

  Future<void> _onCancelInventoryCountStarted(
    CancelInventoryCountStarted event,
    Emitter<CancelInventoryCountState> emit,
  ) async {
    emit(CancelInventoryCountPrepare());

    final result = await repository.cancelInventoryCount(
      payload: CancelInventoryCountPayload(
        id: event.id,
      ),
    );

    result.when(
      success: (model) => emit(CancelInventoryCountSuccess(model: model)),
      failure: (error) => emit(CancelInventoryCountFailure(error: error)),
    );
  }
}
