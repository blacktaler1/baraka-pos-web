import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';
import '../../../../store/store.dart';

part 'low_stock_event.dart';
part 'low_stock_state.dart';

class LowStockBloc extends Bloc<LowStockEvent, LowStockState> {
  final StoreRepository repository;

  LowStockBloc({required this.repository}) : super(LowStockInitial()) {
    on<LowStockEvent>(_onLowStockEvent);
  }
  Future<void> _onLowStockEvent(
    LowStockEvent event,
    Emitter<LowStockState> emit,
  ) async {
    emit(LowStockInitial());

    emit(LowStockPrepare());

    final result = await repository.getAllProducts(
        payload: GetAllProductPayload(
      search: event.search,
      category: event.category,
      cursor: event.cursor,
      pageSize: event.pageSize,
      firmaId: event.firmaId,
      lowStrock: event.lowStock,
    ));

    result.when(
      success: (model) => emit(
        LowStockSuccess(
          model: model,
        ),
      ),
      failure: (error) => emit(
        LowStockFailure(
          error: error,
        ),
      ),
    );
  }
}
