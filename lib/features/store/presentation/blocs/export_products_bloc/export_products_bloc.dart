import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../../global/domain/domain.dart';
import '../../../domain/domain.dart';

part 'export_products_event.dart';
part 'export_products_state.dart';

class ExportProductsBloc
    extends Bloc<ExportProductsEvent, ExportProductsState> {
  final StoreRepository repository;

  ExportProductsBloc({required this.repository})
      : super(ExportProductsInitial()) {
    on<ExportProductsStarted>(_onExportProductsStarted);
  }

  Future<void> _onExportProductsStarted(
    ExportProductsStarted event,
    Emitter<ExportProductsState> emit,
  ) async {
    emit(ExportProductsPrepare());

    final result = await repository.exportProducts(
      payload: ExportProductsPayload(),
    );

    result.when(
      success: (model) => emit(ExportProductsSuccess(model: model)),
      failure: (error) => emit(ExportProductsFailure(error: error)),
    );
  }
}
