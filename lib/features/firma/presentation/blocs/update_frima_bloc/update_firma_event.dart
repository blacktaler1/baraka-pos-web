part of 'update_firma_bloc.dart';

sealed class UpdateFirmaEvent extends Equatable {
  const UpdateFirmaEvent();

  @override
  List<Object> get props => [];
}

final class UpdateFirmaStarted extends UpdateFirmaEvent {
  final String title;
  final String phone;
  final String address;
  final List imageIds;
  final int pk;

  const UpdateFirmaStarted({
    required this.title,
    required this.phone,
    required this.address,
    required this.imageIds,
    required this.pk,
  });

  @override
  List<Object> get props => [
        "title: $title",
        "phone: $phone",
        "address: $address",
        "image_ids: $imageIds",
        "pk: $pk",
      ];
}
