import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/domain.dart';

part 'close_shift_event.dart';
part 'close_shift_state.dart';

class CloseShiftBloc extends Bloc<CloseShiftEvent, CloseShiftState> {
  final ShiftRepository repository;

  CloseShiftBloc({required this.repository}) : super(CloseShiftInitial()) {
    on<CloseShiftStarted>(_onCloseShiftStarted);
  }

  Future<void> _onCloseShiftStarted(
    CloseShiftStarted event,
    Emitter<CloseShiftState> emit,
  ) async {
    emit(CloseShiftPrepare());

    final result = await repository.closeShift(
      payload: CloseShiftPayload(
        id: event.id,
        closingCash: event.closingCash,
        note: event.note,
      ),
    );

    result.when(
      success: (model) => emit(CloseShiftSuccess(model: model)),
      failure: (error) => emit(CloseShiftFailure(error: error)),
    );
  }
}
