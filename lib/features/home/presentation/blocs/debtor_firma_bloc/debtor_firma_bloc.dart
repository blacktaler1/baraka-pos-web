import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';
import '../../../../firma/domain/domain.dart';

part 'debtor_firma_event.dart';
part 'debtor_firma_state.dart';

class DebtorFirmaBloc extends Bloc<DebtorFirmaEvent, DebtorFirmaState> {
  final FirmaRepository repository;

  DebtorFirmaBloc({required this.repository}) : super(DebtorFirmaInitial()) {
    on<DebtorFirmaEvent>(_onDebtorFirmaEvent);
  }

  Future<void> _onDebtorFirmaEvent(
    DebtorFirmaEvent event,
    Emitter<DebtorFirmaState> emit,
  ) async {
    emit(DebtorFirmaInitial());

    emit(DebtorFirmaPrepare());

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
        DebtorFirmaSuccess(model: model),
      ),
      failure: (error) => emit(
        DebtorFirmaFailure(error: error),
      ),
    );
  }
}
