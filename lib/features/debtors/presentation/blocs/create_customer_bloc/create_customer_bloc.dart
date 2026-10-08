import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/model/customer_model.dart';
import '../../../domain/payload/create_customer_payload.dart';
import '../../../domain/repository/debtors_repository.dart';

part 'create_customer_event.dart';
part 'create_customer_state.dart';

class CreateCustomerBloc
    extends Bloc<CreateCustomerEvent, CreateCustomerState> {
  final DebtorsRepository repository;

  CreateCustomerBloc({required this.repository})
      : super(CreateCustomerInitial()) {
    on<CreateCustomerStarted>(_onCreateCustomerStarted);
  }

  Future<void> _onCreateCustomerStarted(
    CreateCustomerStarted event,
    Emitter<CreateCustomerState> emit,
  ) async {
    emit(CreateCustomerInitial());
    emit(CreateCustomerPrepare());

    final result = await repository.createCustomer(
      payload: CreateCustomerPayload(
        fullName: event.fullName,
        phone: event.phone,
        address: event.address,
      ),
    );

    result.when(
      success: (model) => emit(
        CreateCustomerSuccess(model: model),
      ),
      failure: (error) => emit(
        CreateCustomerFailure(error: error),
      ),
    );
  }
}
