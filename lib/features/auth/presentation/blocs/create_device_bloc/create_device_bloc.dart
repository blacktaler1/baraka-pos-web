import 'package:bloc/bloc.dart';
import 'package:baraka_pos/features/auth/auth.dart';
import 'package:baraka_pos/features/global/domain/domain.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';

part 'create_device_event.dart';
part 'create_device_state.dart';

class CreateDeviceBloc extends Bloc<CreateDeviceEvent, CreateDeviceState> {
  final AuthRepository repository;

  CreateDeviceBloc({required this.repository}) : super(CreateDeviceInitial()) {
    on<CreateDeviceEvent>(_onCreateDeviceEvent);
  }

  Future<void> _onCreateDeviceEvent(
    CreateDeviceEvent event,
    Emitter<CreateDeviceState> emit,
  ) async {
    emit(CreateDeviceInitial());

    emit(CreateDevicePrepare());

    final result = await repository.createDevice(
      payload: CreateDevicePayload(
        name: event.name,
        deviceId: event.deviceId,
      ),
    );

    result.when(
      success: (model) => emit(
        CreateDeviceSuccess(model: model),
      ),
      failure: (error) => emit(
        CreateDeviceFailure(error: error),
      ),
    );
  }
}
