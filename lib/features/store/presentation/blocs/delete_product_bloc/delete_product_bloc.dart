import 'package:bloc/bloc.dart';
import 'package:baraka_pos/features/store/domain/domain.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';
import '../../../../global/global.dart';

part 'delete_product_event.dart';
part 'delete_product_state.dart';

class DeleteProductBloc extends Bloc<DeleteProductEvent, DeleteProductState> {
  final StoreRepository repository;
  DeleteProductBloc({required this.repository})
      : super(DeleteProductInitial()) {
    on<DeleteProductEvent>(_onDeleteProductEvent);
  }

  Future<void> _onDeleteProductEvent(
    DeleteProductEvent event,
    Emitter<DeleteProductState> emit,
  ) async {
    emit(DeleteProductInitial());

    emit(DeleteProductPrepare());

    final result = await repository.deleteProduct(
      payload: DeleteProductPayload(id: event.id),
    );

    result.when(
      success: (model) => emit(
        DeleteProductSuccess(model: model),
      ),
      failure: (error) => emit(
        DeleteProductFailure(error: error),
      ),
    );
  }
}
