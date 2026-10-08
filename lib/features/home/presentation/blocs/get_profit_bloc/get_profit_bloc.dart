import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';
import '../../../domain/domain.dart';

part 'get_profit_event.dart';
part 'get_profit_state.dart';

class GetProfitBloc extends Bloc<GetProfitEvent, GetProfitState> {
  final DashboardRepository repository;

  GetProfitBloc({required this.repository}) : super(GetProfitInitial()) {
    on<GetProfitEvent>(_onGetProfitEvent);
  }

  Future<void> _onGetProfitEvent(
    GetProfitEvent event,
    Emitter<GetProfitState> emit,
  ) async {
    emit(GetProfitInitial());

    emit(GetProfitPrepare());

    final result = await repository.getProfit(
      payload: GetProfitCardPayload(
        period: event.period,
        cursor: event.cursor,
        pageSize: event.pageSize,
      ),
    );

    result.when(
      success: (model) => emit(
        GetProfitSuccess(model: model),
      ),
      failure: (error) => emit(
        GetProfitFailure(error: error),
      ),
    );
  }
}
