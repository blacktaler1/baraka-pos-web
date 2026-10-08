import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/model/create_item_collection.dart';
import '../../../domain/model/transaction_model.dart';
import '../../../domain/payload/create_transaction_payload.dart';
import '../../../domain/repository/cash_repository.dart';

part 'create_transaction_event.dart';
part 'create_transaction_state.dart';

class CreateTransactionBloc
    extends Bloc<CreateTransactionEvent, CreateTransactionState> {
  final CashRepository repository;

  CreateTransactionBloc({required this.repository})
      : super(CreateTransactionInitial()) {
    on<CreateTransactionStarted>(_onCreateTransactionStarted);
  }

  Future<void> _onCreateTransactionStarted(
    CreateTransactionStarted event,
    Emitter<CreateTransactionState> emit,
  ) async {
    emit(CreateTransactionPrepare());

    final result = await repository.createTransaction(
      payload: CreateTransactionPayload(
        paymentMethod: event.paymentMethod,
        customer: event.customer,
        paidAmount: event.paidAmount,
        deadline: event.deadline,
        description: event.description,
        discount: event.discount,
        items: event.items,
      ),
    );

    result.when(
      success: (model) => emit(
        CreateTransactionSuccess(model: model),
      ),
      failure: (error) => emit(
        CreateTransactionFailure(error: error),
      ),
    );
  }
}
