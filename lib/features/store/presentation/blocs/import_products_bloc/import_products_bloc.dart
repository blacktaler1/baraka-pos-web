import 'package:cross_file/cross_file.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/domain.dart';

part 'import_products_event.dart';
part 'import_products_state.dart';

class ImportProductsBloc
    extends Bloc<ImportProductsEvent, ImportProductsState> {
  final StoreRepository repository;

  ImportProductsBloc({required this.repository})
      : super(ImportProductsInitial()) {
    on<ImportProductsStarted>(_onImportProductsStarted);
  }

  Future<void> _onImportProductsStarted(
    ImportProductsStarted event,
    Emitter<ImportProductsState> emit,
  ) async {
    emit(ImportProductsPrepare());

    final result = await repository.importProducts(
      payload: ImportProductsPayload(
        file: event.file,
      ),
    );

    result.when(
      success: (model) => emit(ImportProductsSuccess(model: model)),
      failure: (error) => emit(ImportProductsFailure(error: error)),
    );
  }
}
