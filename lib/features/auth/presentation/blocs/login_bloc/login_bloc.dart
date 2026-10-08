import 'package:bloc/bloc.dart';
import 'package:baraka_pos/shared/shared.dart';
import 'package:equatable/equatable.dart';

import '../../../auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository repository;
  LoginBloc({required this.repository}) : super(LoginInitial()) {
    on<LoginStarted>(_onLoginStarted);
  }

  Future<void> _onLoginStarted(
    LoginStarted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginInitial());

    emit(LoginPrepare());

    final result = await repository.login(
      payload: LoginPayload(
          code: event.code,
          number: event.phoneNumber,
          password: event.password),
    );

    result.when(
      success: (model) => emit(
        LoginSuccess(model: model),
      ),
      failure: (error) => emit(
        LoginFailure(error: error),
      ),
    );
  }
}
