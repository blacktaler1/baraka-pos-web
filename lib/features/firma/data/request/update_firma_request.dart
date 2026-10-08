import 'package:baraka_pos/features/firma/domain/domain.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';

final class UpdateFirmaRequest extends RemoteRequest<UpdateFirmaPayload> {
  final String title;
  final String phone;
  final String address;
  final List imageIds;
  final int pk;

  UpdateFirmaRequest.fromPayload(super.payload)
      : title = payload.title,
        phone = payload.phone,
        address = payload.address,
        imageIds = payload.imageIds,
        pk = payload.pk,
        super.fromPayload();

  @override
  Json data() => {
        if (title.isNotEmpty) 'title': title,
        if (phone.isNotEmpty) 'phone': phone,
        if (address.isNotEmpty) 'address': address,
        if (imageIds.isNotEmpty) 'image_ids': imageIds,
      };
  @override
  Map<String, String> path() => {
        'pk': pk.toString(),
      };

  @override
  Map<String, String> query() => {};
}
