part of 'create_device_bloc.dart';

final class CreateDeviceEvent extends Equatable {
  final String name;
  final String deviceId;

  const CreateDeviceEvent({
    required this.deviceId,
    required this.name,
  });

  @override
  List<Object> get props => [];
}
