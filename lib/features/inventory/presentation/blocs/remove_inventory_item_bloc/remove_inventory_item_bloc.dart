import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/domain.dart';

part 'remove_inventory_item_event.dart';
part 'remove_inventory_item_state.dart';

class RemoveInventoryItemBloc
    extends Bloc<RemoveInventoryItemEvent, RemoveInventoryItemState> {
  final InventoryRepository repository;

  RemoveInventoryItemBloc({required this.repository})
      : super(RemoveInventoryItemInitial()) {
    on<RemoveInventoryItemStarted>(_onRemoveInventoryItemStarted);
  }

  Future<void> _onRemoveInventoryItemStarted(
    RemoveInventoryItemStarted event,
    Emitter<RemoveInventoryItemState> emit,
  ) async {
    emit(RemoveInventoryItemPrepare());

    final result = await repository.removeInventoryItem(
      payload: RemoveInventoryItemPayload(
        countId: event.countId,
        itemId: event.itemId,
      ),
    );

    result.when(
      success: (model) => emit(RemoveInventoryItemSuccess(model: model)),
      failure: (error) => emit(RemoveInventoryItemFailure(error: error)),
    );
  }
}
