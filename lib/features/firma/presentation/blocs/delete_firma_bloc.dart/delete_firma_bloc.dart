import 'package:bloc/bloc.dart';
import 'package:baraka_pos/features/firma/domain/domain.dart';
import 'package:baraka_pos/features/global/global.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/aplication.dart';

part 'delete_firma_event.dart';
part 'delete_firma_state.dart';

class DeleteFirmaBloc extends Bloc<DeleteFirmaEvent, DeleteFirmaState> {
  final FirmaRepository repository;
  DeleteFirmaBloc({required this.repository}) : super(DeleteFirmaInitial()) {
    on<DeleteFirmaEvent>(_onDeleteFirmaEvent);
  }

  Future<void> _onDeleteFirmaEvent(
    DeleteFirmaEvent event,
    Emitter<DeleteFirmaState> emit,
  ) async {
    emit(DeleteFirmaInitial());

    emit(DeleteFirmaPrepare());

    final result = await repository.deleteFirma(
      payload: DeleteFirmaPayload(id: event.id),
    );

    result.when(
      success: (model) => emit(
        DeleteFirmaSuccess(model: model),
      ),
      failure: (error) => emit(
        DeleteFirmaFailure(error: error),
      ),
    );
  }
}
