import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/model/get_customer_model.dart';
import '../../../domain/payload/get_customer_payload.dart';
import '../../../domain/repository/debtors_repository.dart';

part 'get_customer_event.dart';
part 'get_customer_state.dart';

class GetCustomerBloc extends Bloc<GetCustomerEvent, GetCustomerState> {
  final DebtorsRepository repository;

  GetCustomerBloc({required this.repository}) : super(GetCustomerInitial()) {
    on<GetCustomerStarted>(_onGetCustomerStarted);
  }

  Future<void> _onGetCustomerStarted(
    GetCustomerStarted event,
    Emitter<GetCustomerState> emit,
  ) async {
    emit(GetCustomerInitial());
    emit(GetCustomerPrepare());

    final result = await repository.getCustomer(
      payload: GetCustomerPayload(
          search: event.search, pageSize: event.pageSize, cursor: event.cursor),
    );

    result.when(
      success: (model) => emit(
        GetCustomerSuccess(model: model),
      ),
      failure: (error) => emit(
        GetCustomerFailure(error: error),
      ),
    );
  }
}
