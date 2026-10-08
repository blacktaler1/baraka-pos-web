import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/model/all_firma_model.dart';
import '../../../domain/payload/get_firma_payload.dart';
import '../../../domain/repository/firma_repository.dart';

part 'get_firma_event.dart';
part 'get_firma_state.dart';

class GetFirmaBloc extends Bloc<GetFirmaEvent, GetFirmaState> {
  final FirmaRepository repository;

  GetFirmaBloc({required this.repository}) : super(GetFirmaInitial()) {
    on<GetFirmaStarted>(_onGetFirmaStarted);
  }

  Future<void> _onGetFirmaStarted(
    GetFirmaStarted event,
    Emitter<GetFirmaState> emit,
  ) async {
    emit(GetFirmaInitial());

    emit(GetFirmaPrepare());

    final result = await repository.getFirma(
      payload: GetFirmaPayload(
        search: event.search,
        cursor: event.cursor,
        pageSize: event.pageSize,
        debt: event.debt,
      ),
    );

    result.when(
      success: (model) => emit(
        GetFirmaSuccess(model: model),
      ),
      failure: (error) => emit(
        GetFirmaFailure(error: error),
      ),
    );
  }
}
