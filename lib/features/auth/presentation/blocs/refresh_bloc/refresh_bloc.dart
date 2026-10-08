import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../domain/model/login_model.dart';
import '../../../domain/payload/refresh_payload.dart';
import '../../../domain/repository/auth_repository.dart';

part 'refresh_event.dart';
part 'refresh_state.dart';

class RefreshBloc extends Bloc<RefreshEvent, RefreshState> {
  final AuthRepository repository;

  RefreshBloc({required this.repository}) : super(RefreshInitial()) {
    on<RefreshStarted>(_onRefreshStarted);
  }

  Future<void> _onRefreshStarted(
    RefreshStarted event,
    Emitter<RefreshState> emit,
  ) async {
    emit(RefreshInitial());

    emit(RefreshPrepare());
    final result = await repository.refresh(
      payload: RefreshPayload(refresh: event.refresh),
    );
    result.when(
      success: (model) => emit(
        RefreshSuccess(model: model),
      ),
      failure: (error) => emit(
        RefreshFailure(error: error),
      ),
    );
  }
}
