import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/domain.dart';

part 'get_shifts_event.dart';
part 'get_shifts_state.dart';

class GetShiftsBloc extends Bloc<GetShiftsEvent, GetShiftsState> {
  final ShiftRepository repository;

  GetShiftsBloc({required this.repository}) : super(GetShiftsInitial()) {
    on<GetShiftsStarted>(_onGetShiftsStarted);
  }

  Future<void> _onGetShiftsStarted(
    GetShiftsStarted event,
    Emitter<GetShiftsState> emit,
  ) async {
    emit(GetShiftsPrepare());

    final result = await repository.getShifts(
      payload: GetShiftsPayload(
        cursor: event.cursor,
        pageSize: event.pageSize,
        from: event.from,
        to: event.to,
      ),
    );

    result.when(
      success: (model) => emit(GetShiftsSuccess(model: model)),
      failure: (error) => emit(GetShiftsFailure(error: error)),
    );
  }
}
