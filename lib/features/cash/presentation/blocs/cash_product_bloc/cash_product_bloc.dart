import 'package:bloc/bloc.dart';
import 'package:baraka_pos/features/cash/cash.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';

part 'cash_product_event.dart';
part 'cash_product_state.dart';

class CashProductBloc extends Bloc<CashProductEvent, CashProductState> {
  final CashRepository repository;

  CashProductBloc({required this.repository}) : super(CashProductInitial()) {
    on<CashProductStarted>(_onCashProductStarted);
  }

  Future<void> _onCashProductStarted(
    CashProductStarted event,
    Emitter<CashProductState> emit,
  ) async {
    emit(CashProductInitial());

    emit(CashProductPrepare());

    final result = await repository.getAllCashProduct(
      payload: CashProductPayload(
        search: event.search,
        category: event.category,
        cursor: event.cursor,
        pageSize: event.pageSize,
      ),
    );

    result.when(
      success: (model) => emit(
        CashProductSuccess(model: model),
      ),
      failure: (error) => emit(
        CashProductFailure(error: error),
      ),
    );
  }
}
