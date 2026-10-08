import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/domain.dart';

part 'open_shift_event.dart';
part 'open_shift_state.dart';

class OpenShiftBloc extends Bloc<OpenShiftEvent, OpenShiftState> {
  final ShiftRepository repository;

  OpenShiftBloc({required this.repository}) : super(OpenShiftInitial()) {
    on<OpenShiftStarted>(_onOpenShiftStarted);
  }

  Future<void> _onOpenShiftStarted(
    OpenShiftStarted event,
    Emitter<OpenShiftState> emit,
  ) async {
    emit(OpenShiftPrepare());

    final result = await repository.openShift(
      payload: OpenShiftPayload(
        openingCash: event.openingCash,
      ),
    );

    result.when(
      success: (model) => emit(OpenShiftSuccess(model: model)),
      failure: (error) => emit(OpenShiftFailure(error: error)),
    );
  }
}
