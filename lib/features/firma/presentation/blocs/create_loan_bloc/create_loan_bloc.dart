import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/model/loan_firma_model.dart';
import '../../../domain/payload/create_loan_payload.dart';
import '../../../domain/repository/firma_repository.dart';

part 'create_loan_event.dart';
part 'create_loan_state.dart';

class CreateLoanBloc extends Bloc<CreateLoanEvent, CreateLoanState> {
  final FirmaRepository repository;

  CreateLoanBloc({required this.repository}) : super(CreateLoanInitial()) {
    on<CreateLoanStarted>(_onCreateLoanStarted);
  }

  Future<void> _onCreateLoanStarted(
    CreateLoanStarted event,
    Emitter<CreateLoanState> emit,
  ) async {
    emit(CreateLoanInitial());

    emit(CreateLoanPrepare());
    final result = await repository.createLoan(
      payload: CreateLoanPayload(
        title: event.title,
        paid: event.paid,
        debt: event.debt,
        firmaId: event.firmaId,
      ),
    );

    result.when(
      success: (model) => emit(
        CreateLoanSuccess(model: model),
      ),
      failure: (error) => emit(
        CreateLoanFailure(error: error),
      ),
    );
  }
}
