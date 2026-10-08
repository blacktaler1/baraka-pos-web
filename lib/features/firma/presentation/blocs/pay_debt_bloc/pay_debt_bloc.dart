import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/model/loan_firma_model.dart';
import '../../../domain/payload/pay_debt_payload.dart';
import '../../../domain/repository/firma_repository.dart';

part 'pay_debt_event.dart';
part 'pay_debt_state.dart';

class LoanFirmaBloc extends Bloc<LoanFirmaEvent, LoanFirmaState> {
  final FirmaRepository repository;

  LoanFirmaBloc({required this.repository}) : super(LoanFirmaInitial()) {
    on<LoanFirmaStarted>(_onPayDebtStarted);
  }

  Future<void> _onPayDebtStarted(
    LoanFirmaStarted event,
    Emitter<LoanFirmaState> emit,
  ) async {
    emit(LoanFirmaInitial());

    emit(LoanFirmaPrepare());

    final result = await repository.payDebt(
      payload: LoanFirmaPayload(
        firmaId: event.firmaId,
        debtId: event.debtId,
        amount: event.amount,
      ),
    );

    result.when(
      success: (model) => emit(
        LoanFirmaSuccess(model: model),
      ),
      failure: (error) => emit(
        LoanFirmaFailure(error: error),
      ),
    );
  }
}
