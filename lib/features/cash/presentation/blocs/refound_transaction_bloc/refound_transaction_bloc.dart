import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/model/create_item_collection.dart';
import '../../../domain/model/refound_model.dart';
import '../../../domain/payload/refound_transaction_payload.dart';
import '../../../domain/repository/cash_repository.dart';

part 'refound_transaction_event.dart';
part 'refound_transaction_state.dart';

class RefoundTransactionBloc
    extends Bloc<RefoundTransactionEvent, RefoundTransactionState> {
  final CashRepository repository;

  RefoundTransactionBloc({required this.repository})
      : super(RefoundTransactionInitial()) {
    on<RefoundTransactionStarted>(_onRefoundTransactionStarted);
  }

  Future<void> _onRefoundTransactionStarted(
    RefoundTransactionStarted event,
    Emitter<RefoundTransactionState> emit,
  ) async {
    emit(RefoundTransactionPrepare());

    final result = await repository.refoundTransaction(
      payload: RefoundTransactionPayload(
        transactionId: event.transactionId,
        description: event.description,
        items: event.items,
      ),
    );

    result.when(
      success: (model) => emit(
        RefoundTransactionSuccess(model: model),
      ),
      failure: (error) => emit(
        RefoundTransactionFailure(error: error),
      ),
    );
  }
}
