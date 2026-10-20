import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/model/product_history_model.dart';
import '../../../domain/payload/product_history_payload.dart';
import '../../../domain/repository/store_repository.dart';

part 'product_history_event.dart';
part 'product_history_state.dart';

class ProductHistoryBloc
    extends Bloc<ProductHistoryEvent, ProductHistoryState> {
  final StoreRepository repository;

  ProductHistoryBloc({required this.repository})
      : super(ProductHistoryInitial()) {
    on<ProductHistoryStarted>(_onProductHistoryStarted);
  }

  Future<void> _onProductHistoryStarted(
    ProductHistoryStarted event,
    Emitter<ProductHistoryState> emit,
  ) async {
    // "Yana yuklash"da ro'yxat ekranda qoladi — faqat birinchi sahifada loader
    final previous = state;
    final append = event.offset > 0 && previous is ProductHistorySuccess;
    emit(append ? ProductHistoryLoadingMore(model: previous.model) : ProductHistoryPrepare());

    final result = await repository.getProductHistory(
      payload: ProductHistoryPayload(
        pk: event.pk,
        type: event.type,
        offset: event.offset,
      ),
    );

    result.when(
      success: (model) => emit(
        ProductHistorySuccess(
          model: append
              ? ProductHistoryModel(
                  summary: model.summary,
                  movements: [...previous.model.movements, ...model.movements],
                  count: model.count,
                  hasMore: model.hasMore,
                )
              : model,
        ),
      ),
      failure: (error) => emit(
        ProductHistoryFailure(error: error),
      ),
    );
  }
}
