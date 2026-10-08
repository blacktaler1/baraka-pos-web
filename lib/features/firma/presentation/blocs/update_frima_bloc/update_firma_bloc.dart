import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/model/firma_model.dart';
import '../../../domain/payload/update_firma_payload.dart';
import '../../../domain/repository/firma_repository.dart';

part 'update_firma_event.dart';
part 'update_firma_state.dart';

class UpdateFirmaBloc extends Bloc<UpdateFirmaEvent, UpdateFirmaState> {
  final FirmaRepository repository;
  UpdateFirmaBloc({required this.repository}) : super(UpdateFirmaInitial()) {
    on<UpdateFirmaStarted>(_onUpdateFirmaStarted);
  }

  Future<void> _onUpdateFirmaStarted(
    UpdateFirmaStarted event,
    Emitter<UpdateFirmaState> emit,
  ) async {
    emit(UpdateFirmaInitial());

    emit(UpdateFirmaPrepare());
    final result = await repository.updateFirma(
      payload: UpdateFirmaPayload(
        title: event.title,
        phone: event.phone,
        address: event.address,
        imageIds: event.imageIds,
        pk: event.pk,
      ),
    );

    result.when(
      success: (model) => emit(
        UpdateFirmaSuccess(model: model),
      ),
      failure: (error) => emit(
        UpdateFirmaFailure(error: error),
      ),
    );
  }
}
