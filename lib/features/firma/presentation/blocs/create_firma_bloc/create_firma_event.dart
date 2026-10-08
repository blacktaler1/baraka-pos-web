part of 'create_firma_bloc.dart';

sealed class CreateFirmaEvent extends Equatable {
  const CreateFirmaEvent();

  @override
  List<Object> get props => [];
}

final class CreateFirmaStarted extends CreateFirmaEvent {
  final String title;
  final String phone;
  final String address;
  final List imageIds;

  const CreateFirmaStarted({
    required this.title,
    required this.phone,
    required this.address,
    required this.imageIds,
  });

  @override
  List<Object> get props => [
        "title: $title",
        "phone: $phone",
        "address: $address",
        "image_ids: $imageIds",
      ];
}
