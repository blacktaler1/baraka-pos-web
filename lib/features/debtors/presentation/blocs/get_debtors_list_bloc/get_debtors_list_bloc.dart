import 'package:bloc/bloc.dart';
import 'package:baraka_pos/features/debtors/domain/domain.dart';

import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';

part 'get_debtors_list_event.dart';
part 'get_debtors_list_state.dart';

class GetDebtorsListBloc
    extends Bloc<GetDebtorsListEvent, GetDebtorsListState> {
  final DebtorsRepository repository;
  GetDebtorsListBloc({
    required this.repository,
  }) : super(GetDebtorsListInitial()) {
    on<GetDebtorsListEvent>(_onGetDebtorsListEvent);
  }
  Future<void> _onGetDebtorsListEvent(
    GetDebtorsListEvent event,
    Emitter<GetDebtorsListState> emit,
  ) async {
    emit(GetDebtorsListInitial());

    emit(GetDebtorsListPrepare());

    final result = await repository.getDebtorsList(
      payload: GetDebtorsPayload(
        hasDebt: event.hasDebt,
        nearingDeadline: event.nearingDeadline,
        search: event.search,
        ordering: event.ordering,
        pageSize: event.pageSize,
      ),
    );

    result.when(
      success: (model) => emit(
        GetDebtorsListSuccess(model: model),
      ),
      failure: (error) => emit(
        GetDebtorsListFailure(error: error),
      ),
    );
  }
}
