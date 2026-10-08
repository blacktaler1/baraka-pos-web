import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/model/all_transaction_model.dart';
import '../../../domain/payload/get_transaction_payload.dart';
import '../../../domain/repository/cash_repository.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final CashRepository repository;

  TransactionBloc({required this.repository}) : super(TransactionInitial()) {
    on<TransactionStarted>(_onTransactionStarted);
  }

  Future<void> _onTransactionStarted(
    TransactionStarted event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionInitial());
    emit(TransactionPrepare());

    final result = await repository.getAllTransaction(
      payload: GetTransactionPayload(
        from: event.from,
        to: event.to,
        search: event.search,
        cursor: event.cursor,
        pageSize: event.pageSize,
      ),
    );

    result.when(
      success: (model) => emit(
        TransactionSuccess(model: model),
      ),
      failure: (error) => emit(
        TransactionFailure(error: error),
      ),
    );
  }
}
