import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/domain.dart';

part 'get_inventory_count_event.dart';
part 'get_inventory_count_state.dart';

class GetInventoryCountBloc
    extends Bloc<GetInventoryCountEvent, GetInventoryCountState> {
  final InventoryRepository repository;

  GetInventoryCountBloc({required this.repository})
      : super(GetInventoryCountInitial()) {
    on<GetInventoryCountStarted>(_onGetInventoryCountStarted);
  }

  Future<void> _onGetInventoryCountStarted(
    GetInventoryCountStarted event,
    Emitter<GetInventoryCountState> emit,
  ) async {
    emit(GetInventoryCountPrepare());

    final result = await repository.getInventoryCount(
      payload: GetInventoryCountPayload(
        id: event.id,
      ),
    );

    result.when(
      success: (model) => emit(GetInventoryCountSuccess(model: model)),
      failure: (error) => emit(GetInventoryCountFailure(error: error)),
    );
  }
}
