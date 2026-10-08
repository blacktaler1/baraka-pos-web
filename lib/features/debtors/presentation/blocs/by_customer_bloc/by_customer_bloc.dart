import 'package:bloc/bloc.dart';
import 'package:baraka_pos/features/debtors/debtors.dart';
import 'package:equatable/equatable.dart';
import '../../../../../shared/shared.dart';

part 'by_customer_event.dart';
part 'by_customer_state.dart';

class ByCustomerBloc extends Bloc<ByCustomerEvent, ByCustomerState> {
  final DebtorsRepository repository;
  ByCustomerBloc({required this.repository}) : super(ByCustomerInitial()) {
    on<ByCustomerEvent>(_onByCustomerEvent);
  }

  Future<void> _onByCustomerEvent(
    ByCustomerEvent event,
    Emitter<ByCustomerState> emit,
  ) async {
    emit(ByCustomerInitial());

    emit(ByCustomerPrepare());

    final result = await repository.byCustomer(
      payload: ByCustomerPayload(
        id: event.id,
      ),
    );

    result.when(
      success: (model) => emit(
        ByCustomerSuccess(model: model),
      ),
      failure: (error) => emit(
        ByCustomerFailure(error: error),
      ),
    );
  }
}
