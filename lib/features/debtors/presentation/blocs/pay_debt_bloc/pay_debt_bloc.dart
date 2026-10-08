import 'package:bloc/bloc.dart';
import 'package:baraka_pos/features/debtors/debtors.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';

part 'pay_debt_event.dart';
part 'pay_debt_state.dart';

class PayDebtBloc extends Bloc<PayDebtEvent, PayDebtState> {
  final DebtorsRepository repository;
  PayDebtBloc({required this.repository}) : super(PayDebtInitial()) {
    on<PayDebtEvent>(_onPayDebtEvent);
  }

  Future<void> _onPayDebtEvent(
    PayDebtEvent event,
    Emitter<PayDebtState> emit,
  ) async {
    emit(PayDebtInitial());

    emit(PayDebtPrepare());

    final result = await repository.payDebt(
      payload: PayDebtPayload(
        debtId: event.id,
        amount: event.amount,
      ),
    );

    result.when(
      success: (model) => emit(
        PayDebtSuccess(model: model),
      ),
      failure: (error) => emit(
        PayDebtFailure(error: error),
      ),
    );
  }
}
