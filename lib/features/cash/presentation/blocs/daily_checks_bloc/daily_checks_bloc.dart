import 'package:bloc/bloc.dart';
import 'package:baraka_pos/shared/shared.dart';
import 'package:equatable/equatable.dart';

import '../../../cash.dart';

part 'daily_checks_event.dart';
part 'daily_checks_state.dart';

class DailyChecksBloc extends Bloc<DailyChecksEvent, DailyChecksState> {
  final CashRepository repository;
  DailyChecksBloc({required this.repository}) : super(DailyChecksInitial()) {
    on<DailyChecksStarted>(_onDailyChecksStarted);
  }

  Future<void> _onDailyChecksStarted(
    DailyChecksStarted event,
    Emitter<DailyChecksState> emit,
  ) async {
    emit(DailyChecksInitial());

    emit(DailyChecksPrepare());

    final result = await repository.getDailyCheks(
      payload: DailyChecksPayload(
        from: event.from,
        to: event.to,
      ),
    );

    result.when(
      success: (model) => emit(
        DailyChecksSuccess(model: model),
      ),
      failure: (error) => emit(
        DailyChecksFailure(error: error),
      ),
    );
  }
}
