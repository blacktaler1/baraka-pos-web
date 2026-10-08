import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/domain.dart';

part 'pay_customer_debts_event.dart';
part 'pay_customer_debts_state.dart';

class PayCustomerDebtsBloc
    extends Bloc<PayCustomerDebtsEvent, PayCustomerDebtsState> {
  final DebtorsRepository repository;

  PayCustomerDebtsBloc({required this.repository})
      : super(PayCustomerDebtsInitial()) {
    on<PayCustomerDebtsStarted>(_onPayCustomerDebtsStarted);
  }

  Future<void> _onPayCustomerDebtsStarted(
    PayCustomerDebtsStarted event,
    Emitter<PayCustomerDebtsState> emit,
  ) async {
    emit(PayCustomerDebtsPrepare());

    final result = await repository.payCustomerDebts(
      payload: PayCustomerDebtsPayload(
        customerId: event.customerId,
        amount: event.amount,
      ),
    );

    result.when(
      success: (model) => emit(PayCustomerDebtsSuccess(model: model)),
      failure: (error) => emit(PayCustomerDebtsFailure(error: error)),
    );
  }
}
