import 'package:bloc/bloc.dart';
import 'package:baraka_pos/features/settings/settings.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';

part 'change_pass_event.dart';
part 'change_pass_state.dart';

class ChangePassBloc extends Bloc<ChangePassEvent, ChangePassState> {
  final SettingsRepository repository;
  ChangePassBloc({required this.repository}) : super(ChangePassInitial()) {
    on<ChangePassEvent>(_onChangePassEvent);
  }

  Future<void> _onChangePassEvent(
    ChangePassEvent event,
    Emitter<ChangePassState> emit,
  ) async {
    emit(ChangePassInitial());

    emit(ChangePassPrepare());

    final result = await repository.changePass(
      payload: ChangePasswordPayload(
        oldPassword: event.oldPassword,
        newPassword: event.newPassword,
      ),
    );

    result.when(
      success: (model) => emit(
        ChangePassSuccess(model: model),
      ),
      failure: (error) => emit(
        ChangePassFailure(error: error),
      ),
    );
  }
}
