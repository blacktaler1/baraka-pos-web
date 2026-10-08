import 'package:bloc/bloc.dart';
import 'package:baraka_pos/features/home/home.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';

part 'get_dashboard_event.dart';
part 'get_dashboard_state.dart';

class GetDashboardBloc extends Bloc<GetDashboardEvent, GetDashboardState> {
  final DashboardRepository repository;
  GetDashboardBloc({required this.repository}) : super(GetDashboardInitial()) {
    on<GetDashboardEvent>(_onGetDashboardEvent);
  }

  Future<void> _onGetDashboardEvent(
    GetDashboardEvent event,
    Emitter<GetDashboardState> emit,
  ) async {
    emit(GetDashboardInitial());

    emit(GetDashboardPrepare());

    final result = await repository.getDashboard(
      payload: GetDashboardPayload(
        cardsPeriod: event.cardsPeriod,
        chartPeriod: event.chartPeriod,
        topProductPeriod: event.topProductPeriod,
      ),
    );

    result.when(
      success: (model) => emit(
        GetDashboardSuccess(model: model),
      ),
      failure: (error) => emit(
        GetDashboardFailure(error: error),
      ),
    );
  }
}
