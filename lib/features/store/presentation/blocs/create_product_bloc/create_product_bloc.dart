import 'package:bloc/bloc.dart';
import 'package:baraka_pos/features/global/domain/domain.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';
import '../../../domain/domain.dart';

part 'create_product_event.dart';
part 'create_product_state.dart';

class CreateProductBloc extends Bloc<CreateProductEvent, CreateProductState> {
  final StoreRepository repository;
  CreateProductBloc({required this.repository})
      : super(CreateProductInitial()) {
    on<CreateProductStarted>(_onCreateProductStarted);
  }

  Future<void> _onCreateProductStarted(
    CreateProductStarted event,
    Emitter<CreateProductState> emit,
  ) async {
    emit(CreateProductInitial());

    emit(CreateProductPrepare());

    final result = await repository.createProduct(
      payload: CreateProductPayload(
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
        minStock: event.minStock,
      ),
    );

    result.when(
      success: (model) => emit(
        CreateProductSuccess(
          model: model,
        ),
      ),
      failure: (error) => emit(
        CreateProductFailure(
          error: error,
        ),
      ),
    );
  }
}
