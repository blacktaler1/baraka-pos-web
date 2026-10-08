import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';
import '../../../../auth/domain/model/user_model.dart';
import '../../../domain/domain.dart';

part 'update_worker_event.dart';
part 'update_worker_state.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final WorkersRepository repository;

  UpdateUserBloc({required this.repository}) : super(UpdateUserInitial()) {
    on<UpdateUserStarted>(_onUpdateUserStarted);
  }

  Future<void> _onUpdateUserStarted(
    UpdateUserStarted event,
    Emitter<UpdateUserState> emit,
  ) async {
    emit(UpdateUserInitial());

    emit(UpdateUserPrepare());

    final result = await repository.updateUser(payload: event.payload);

    result.when(
      success: (model) => emit(
        UpdateUserSuccess(model: model),
      ),
      failure: (error) => emit(
        UpdateUserFailure(error: error),
      ),
    );

    // if (result.isRight) {
    //   emit(UpdateUserSuccess(result.right!));
    // } else {
    //   emit(UpdateUserFailure(result.left!));
    // }
  }
}
