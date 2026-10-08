import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/model/expense_model.dart';
import '../../../domain/payload/create_expense_payload.dart';
import '../../../domain/repository/expenses_repository.dart';

part 'create_expense_event.dart';
part 'create_expense_state.dart';

class CreateExpenseBloc extends Bloc<CreateExpenseEvent, CreateExpenseState> {
  final ExpensesRepository repository;

  CreateExpenseBloc({required this.repository})
      : super(CreateExpenseInitial()) {
    on<CreateExpenseStarted>(_onCreateExpenseStarted);
  }

  Future<void> _onCreateExpenseStarted(
    CreateExpenseStarted event,
    Emitter<CreateExpenseState> emit,
  ) async {
    emit(CreateExpenseInitial());

    emit(CreateExpensePrepare());

    final result = await repository.createExpense(
      payload: CreateExpensePayload(
        title: event.title,
        amount: event.amount,
      ),
    );

    result.when(
      success: (model) => emit(
        CreateExpenseSuccess(model: model),
      ),
      failure: (error) => emit(
        CreateExpenseFailure(error: error),
      ),
    );
  }
}
