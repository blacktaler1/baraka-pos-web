import 'package:bloc/bloc.dart';
import 'package:baraka_pos/features/global/domain/domain.dart';
import 'package:baraka_pos/features/store/domain/domain.dart';
import 'package:baraka_pos/shared/shared.dart';
import 'package:equatable/equatable.dart';

part 'update_product_event.dart';
part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  final StoreRepository repository;
  UpdateProductBloc({required this.repository})
      : super(UpdateProductInitial()) {
    on<UpdateProductEventStarted>(_onUpdateProductEventStarted);
  }

  Future<void> _onUpdateProductEventStarted(
    UpdateProductEventStarted event,
    Emitter<UpdateProductState> emit,
  ) async {
    emit(UpdateProductInitial());

    emit(UpdateProductPrepare());
    final result = await repository.updateProduct(
      payload: UpdateProductPayload(
        id: event.id,
        title: event.title,
        cost: event.cost,
        price: event.price,
        stock: event.stock,
        categoryId: event.categoryId,
        unit: event.unit,
        packSize: event.packSize,
        imagesIds: event.imagesIds,
        qrCode: event.qrCode,
        firmaId: event.firmaId,
        wholesalePrice: event.wholesalePrice,
        meterPrice: event.meterPrice,
        minStock: event.minStock,
      ),
    );
    print(result);

    result.when(
      success: (model) => emit(
        UpdateProductSuccess(model: model),
      ),
      failure: (error) => emit(
        UpdateProductFailure(error: error),
      ),
    );
  }
}
