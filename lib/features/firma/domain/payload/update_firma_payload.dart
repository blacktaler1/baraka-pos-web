import '../../../../shared/domain/domain.dart';

final class UpdateFirmaPayload extends Payload {
  final String title;
  final String phone;
  final String address;
  final List imageIds;
  final int pk;

  const UpdateFirmaPayload({
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
