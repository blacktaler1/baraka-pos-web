import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/domain.dart';

part 'current_shift_event.dart';
part 'current_shift_state.dart';

class CurrentShiftBloc extends Bloc<CurrentShiftEvent, CurrentShiftState> {
  final ShiftRepository repository;

  CurrentShiftBloc({required this.repository}) : super(CurrentShiftInitial()) {
    on<CurrentShiftStarted>(_onCurrentShiftStarted);
  }

  Future<void> _onCurrentShiftStarted(
    CurrentShiftStarted event,
    Emitter<CurrentShiftState> emit,
  ) async {
    emit(CurrentShiftPrepare());

    final result = await repository.currentShift(
      payload: CurrentShiftPayload(),
    );

    result.when(
      success: (model) => emit(CurrentShiftSuccess(model: model)),
      failure: (error) => emit(CurrentShiftFailure(error: error)),
    );
  }
}
