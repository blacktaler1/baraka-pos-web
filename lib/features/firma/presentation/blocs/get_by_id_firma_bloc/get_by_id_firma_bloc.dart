import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/model/firma_model.dart';
import '../../../domain/payload/get_by_id_firma_payload.dart';
import '../../../domain/repository/firma_repository.dart';

part 'get_by_id_firma_event.dart';
part 'get_by_id_firma_state.dart';

class GetByIdFirmaBloc extends Bloc<GetByIdFirmaEvent, GetByIdFirmaState> {
  final FirmaRepository repository;

  GetByIdFirmaBloc({required this.repository}) : super(GetByIdFirmaInitial()) {
    on<GetByIdFirmaStarted>(_onGetByIdFirmaStarted);
  }

  Future<void> _onGetByIdFirmaStarted(
    GetByIdFirmaStarted event,
    Emitter<GetByIdFirmaState> emit,
  ) async {
    emit(GetByIdFirmaInitial());

    emit(GetByIdFirmaPrepare());
    final result = await repository.getByIdFirma(
      payload: GetByIdFirmaPayload(
        id: event.id,
      ),
    );
    result.when(
      success: (model) => emit(
        GetByIdFirmaSuccess(model: model),
      ),
      failure: (error) => emit(
        GetByIdFirmaFailure(error: error),
      ),
    );
  }
}
