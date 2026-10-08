import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/model/firma_model.dart';
import '../../../domain/payload/create_firma_payload.dart';
import '../../../domain/repository/firma_repository.dart';

part 'create_firma_event.dart';
part 'create_firma_state.dart';

class CreateFirmaBloc extends Bloc<CreateFirmaEvent, CreateFirmaState> {
  final FirmaRepository repository;

  CreateFirmaBloc({required this.repository}) : super(CreateFirmaInitial()) {
    on<CreateFirmaStarted>(_onCreateFirmaStarted);
  }

  Future<void> _onCreateFirmaStarted(
    CreateFirmaStarted event,
    Emitter<CreateFirmaState> emit,
  ) async {
    emit(CreateFirmaInitial());

    emit(CreateFirmaPrepare());
    final result = await repository.createFirma(
      payload: CreateFirmaPayload(
        title: event.title,
        phone: event.phone,
        address: event.address,
        imageIds: event.imageIds,
      ),
    );
    result.when(
      success: (model) => emit(
        CreateFirmaSuccess(model: model),
      ),
      failure: (error) => emit(
        CreateFirmaFailure(error: error),
      ),
    );
  }
}
