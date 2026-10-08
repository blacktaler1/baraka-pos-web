import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';
import '../../../settings.dart';

part 'get_last_version_event.dart';
part 'get_last_version_state.dart';

class GetLastVersionBloc
    extends Bloc<GetLastVersionEvent, GetLastVersionState> {
  final SettingsRepository repository;

  GetLastVersionBloc({required this.repository})
      : super(GetLastVersionInitial()) {
    on<GetLastVersionEvent>(_onGetLastVersionEvent);
  }

  Future<void> _onGetLastVersionEvent(
    GetLastVersionEvent event,
    Emitter<GetLastVersionState> emit,
  ) async {
    emit(GetLastVersionInitial());

    emit(GetLastVersionPrepare());

    final result =
        await repository.getLastVersion(payload: LastVersionPayload());

    result.when(
      success: (model) => emit(
        GetLastVersionSuccess(model: model),
      ),
      failure: (error) => emit(
        GetLastVersionFailure(error: error),
      ),
    );
  }
}
