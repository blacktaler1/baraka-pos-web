import 'package:bloc/bloc.dart';
import 'package:baraka_pos/features/firma/domain/domain.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';

part 'loan_debt_event.dart';
part 'loan_debt_state.dart';

class LoanDebtBloc extends Bloc<LoanDebtEvent, LoanDebtState> {
  final FirmaRepository repository;

  LoanDebtBloc({required this.repository}) : super(LoanDebtInitial()) {
    on<LoanDebtStarted>(_onLoanDebtStarted);
  }

  Future<void> _onLoanDebtStarted(
    LoanDebtStarted event,
    Emitter<LoanDebtState> emit,
  ) async {
    emit(LoanDebtPrepare());

    final result = await repository.getLoan(
      payload: GetLoanPayload(
        search: event.search,
        cursor: event.cursor,
        pageSize: event.pageSize,
        debt: event.debt,
        firmaId: event.firmaId,
      ),
    );

    result.when(
      success: (model) => emit(
        LoanDebtSuccess(model: model),
      ),
      failure: (error) => emit(
        LoanDebtFailure(error: error),
      ),
    );
  }
}
