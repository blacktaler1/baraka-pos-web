import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';
import '../../../domain/domain.dart';

part 'get_turnover_event.dart';
part 'get_turnover_state.dart';

class GetTurnoverBloc extends Bloc<GetTurnoverEvent, GetTurnoverState> {
  final DashboardRepository repository;

  GetTurnoverBloc({required this.repository}) : super(GetTurnoverInitial()) {
    on<GetTurnoverEvent>(_onGetTurnoverEvent);
  }

  Future<void> _onGetTurnoverEvent(
    GetTurnoverEvent event,
    Emitter<GetTurnoverState> emit,
  ) async {
    emit(GetTurnoverInitial());

    emit(GetTurnoverPrepare());

    final result = await repository.getTurnover(
      payload: GetTurnoverCardPayload(
        period: event.period,
        cursor: event.cursor,
        pageSize: event.pageSize,
      ),
    );

    result.when(
      success: (model) => emit(
        GetTurnoverSuccess(model: model),
      ),
      failure: (error) => emit(
        GetTurnoverFailure(error: error),
      ),
    );
  }
}
