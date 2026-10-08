import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/model/all_customer_history_model.dart';
import '../../../domain/payload/by_customer_history_payload.dart';
import '../../../domain/repository/debtors_repository.dart';

part 'by_customer_history_event.dart';
part 'by_customer_history_state.dart';

class ByCustomerHistoryBloc
    extends Bloc<ByCustomerHistoryEvent, ByCustomerHistoryState> {
  final DebtorsRepository repository;
  ByCustomerHistoryBloc({required this.repository})
      : super(ByCustomerHistoryInitial()) {
    on<ByCustomerHistoryStarted>(_onByCustomerHistoryStarted);
  }

  Future<void> _onByCustomerHistoryStarted(
    ByCustomerHistoryStarted event,
    Emitter<ByCustomerHistoryState> emit,
  ) async {
    emit(ByCustomerHistoryPrepare());
    final result = await repository.byCustomerHistory(
      payload: ByCustomerHistoryPayload(
        id: event.id,
        history: event.history,
      ),
    );
    result.when(
      success: (model) => emit(
        ByCustomerHistorySuccess(model: model),
      ),
      failure: (error) => emit(
        ByCustomerHistoryFailure(error: error),
      ),
    );
  }
}
