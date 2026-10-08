import 'package:bloc/bloc.dart';
import 'package:baraka_pos/features/global/domain/domain.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/payload/delete_expense_payload.dart';
import '../../../domain/repository/expenses_repository.dart';

part 'delete_expense_event.dart';
part 'delete_expense_state.dart';

class DeleteExpenseBloc extends Bloc<DeleteExpenseEvent, DeleteExpenseState> {
  final ExpensesRepository repository;

  DeleteExpenseBloc({required this.repository})
      : super(DeleteExpenseInitial()) {
    on<DeleteExpenseStarted>(_onDeleteExpenseStarted);
  }

  Future<void> _onDeleteExpenseStarted(
    DeleteExpenseStarted event,
    Emitter<DeleteExpenseState> emit,
  ) async {
    emit(DeleteExpenseInitial());

    emit(DeleteExpensePrepare());

    final result = await repository.deleteExpense(
      payload: DeleteExpensePayload(
        id: event.id,
      ),
    );

    result.when(
      success: (model) => emit(
        DeleteExpenseSuccess(model: model),
      ),
      failure: (error) => emit(
        DeleteExpenseFailure(error: error),
      ),
    );
  }
}
