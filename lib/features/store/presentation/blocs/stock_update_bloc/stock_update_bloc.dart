import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../../global/domain/model/product_model.dart';
import '../../../domain/payload/stock_update_payload.dart';
import '../../../domain/repository/store_repository.dart';

part 'stock_update_event.dart';
part 'stock_update_state.dart';

class StockUpdateBloc extends Bloc<StockUpdateEvent, StockUpdateState> {
  final StoreRepository repository;

  StockUpdateBloc({required this.repository}) : super(StockUpdateInitial()) {
    on<StockUpdateEventStarted>(_onStockUpdateEventStarted);
  }

  Future<void> _onStockUpdateEventStarted(
    StockUpdateEventStarted event,
    Emitter<StockUpdateState> emit,
  ) async {
    emit(StockUpdateInitial());
    emit(StockUpdatePrepare());
    final result = await repository.updateStock(
      payload: StockUpdatePayload(
        action: event.action,
        amount: event.amount,
        pk: event.pk,
      ),
    );

    result.when(
      success: (model) => emit(
        StockUpdateSuccess(model: model),
      ),
      failure: (error) => emit(
        StockUpdateFailure(error: error),
      ),
    );
  }
}
