import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/model/get_expenses_model.dart';
import '../../../domain/payload/get_expenses_payload.dart';
import '../../../domain/repository/expenses_repository.dart';

part 'get_expenses_event.dart';
part 'get_expenses_state.dart';

class GetExpensesBloc extends Bloc<GetExpensesEvent, GetExpensesState> {
  final ExpensesRepository repository;

  GetExpensesBloc({required this.repository}) : super(GetExpensesInitial()) {
    on<GetExpensesStarted>(_onGetExpensesStarted);
  }

  Future<void> _onGetExpensesStarted(
    GetExpensesStarted event,
    Emitter<GetExpensesState> emit,
  ) async {
    emit(GetExpensesInitial());

    emit(GetExpensesPrepare());

    final result = await repository.getExpenses(
      payload: GetExpensesPayload(
        cursor: event.cursor,
        pageSize: event.pageSize,
      ),
    );

    result.when(
      success: (model) => emit(
        GetExpensesSuccess(model: model),
      ),
      failure: (error) => emit(
        GetExpensesFailure(error: error),
      ),
    );
  }
}
