import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/domain.dart';

part 'add_inventory_item_event.dart';
part 'add_inventory_item_state.dart';

class AddInventoryItemBloc
    extends Bloc<AddInventoryItemEvent, AddInventoryItemState> {
  final InventoryRepository repository;

  AddInventoryItemBloc({required this.repository})
      : super(AddInventoryItemInitial()) {
    on<AddInventoryItemStarted>(_onAddInventoryItemStarted);
  }

  Future<void> _onAddInventoryItemStarted(
    AddInventoryItemStarted event,
    Emitter<AddInventoryItemState> emit,
  ) async {
    emit(AddInventoryItemPrepare());

    final result = await repository.addInventoryItem(
      payload: AddInventoryItemPayload(
        countId: event.countId,
        productId: event.productId,
        countedQuantity: event.countedQuantity,
        mode: event.mode,
      ),
    );

    result.when(
      success: (model) => emit(AddInventoryItemSuccess(model: model)),
      failure: (error) => emit(AddInventoryItemFailure(error: error)),
    );
  }
}
