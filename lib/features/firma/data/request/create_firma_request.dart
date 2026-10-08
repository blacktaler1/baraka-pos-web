import 'package:baraka_pos/features/firma/domain/domain.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';

final class CreateFirmaRequest extends RemoteRequest<CreateFirmaPayload> {
  final String title;
  final String phone;
  final String address;
  final List imageIds;

  CreateFirmaRequest.fromPayload(super.payload)
      : title = payload.title,
        phone = payload.phone,
        address = payload.address,
        imageIds = payload.imageIds,
        super.fromPayload();

  @override
  Json data() => {
        "title": title,
        "phone": phone,
        "address": address,
        "image_ids": imageIds,
      };

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
