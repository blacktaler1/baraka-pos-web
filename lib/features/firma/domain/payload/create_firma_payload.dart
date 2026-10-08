import 'package:baraka_pos/shared/domain/domain.dart';

final class CreateFirmaPayload extends Payload {
  final String title;
  final String phone;
  final String address;
  final List imageIds;

  const CreateFirmaPayload({
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
