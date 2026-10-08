import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/model/expense_model.dart';
import '../../../domain/payload/update_expense_payload.dart';
import '../../../domain/repository/expenses_repository.dart';
part 'update_expense_event.dart';
part 'update_expense_state.dart';

class UpdateExpenseBloc extends Bloc<UpdateExpenseEvent, UpdateExpenseState> {
  final ExpensesRepository repository;

  UpdateExpenseBloc({required this.repository})
      : super(UpdateExpenseInitial()) {
    on<UpdateExpenseStarted>(_onUpdateExpenseStarted);
  }

  Future<void> _onUpdateExpenseStarted(
    UpdateExpenseStarted event,
    Emitter<UpdateExpenseState> emit,
  ) async {
    emit(UpdateExpensePrepare());

    final result = await repository.updateExpense(
      payload: UpdateExpensePayload(
        id: event.id,
        title: event.title,
        amount: event.amount,
      ),
    );

    result.when(
      success: (model) => emit(UpdateExpenseSuccess(model: model)),
      failure: (error) => emit(UpdateExpenseFailure(error: error)),
    );
  }
}
