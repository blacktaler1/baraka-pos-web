import 'package:bloc/bloc.dart';
import 'package:baraka_pos/features/store/domain/domain.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';

part 'all_product_event.dart';
part 'all_product_state.dart';

class AllProductBloc extends Bloc<AllProductEvent, AllProductState> {
  final StoreRepository repository;
  AllProductBloc({required this.repository}) : super(AllProductInitial()) {
    on<AllProductEvent>(_onAllProductEvent);
  }

  Future<void> _onAllProductEvent(
    AllProductEvent event,
    Emitter<AllProductState> emit,
  ) async {
    emit(AllProductInitial());

    emit(AllProductPrepare());

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
        AllProductSuccess(
          model: model,
        ),
      ),
      failure: (error) => emit(
        AllProductFailure(
          error: error,
        ),
      ),
    );
  }
}
