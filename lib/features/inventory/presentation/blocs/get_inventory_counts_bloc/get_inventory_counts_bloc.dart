import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/domain.dart';

part 'get_inventory_counts_event.dart';
part 'get_inventory_counts_state.dart';

class GetInventoryCountsBloc
    extends Bloc<GetInventoryCountsEvent, GetInventoryCountsState> {
  final InventoryRepository repository;

  GetInventoryCountsBloc({required this.repository})
      : super(GetInventoryCountsInitial()) {
    on<GetInventoryCountsStarted>(_onGetInventoryCountsStarted);
  }

  Future<void> _onGetInventoryCountsStarted(
    GetInventoryCountsStarted event,
    Emitter<GetInventoryCountsState> emit,
  ) async {
    emit(GetInventoryCountsPrepare());

    final result = await repository.getInventoryCounts(
      payload: GetInventoryCountsPayload(
        cursor: event.cursor,
        pageSize: event.pageSize,
      ),
    );

    result.when(
      success: (model) => emit(GetInventoryCountsSuccess(model: model)),
      failure: (error) => emit(GetInventoryCountsFailure(error: error)),
    );
  }
}
