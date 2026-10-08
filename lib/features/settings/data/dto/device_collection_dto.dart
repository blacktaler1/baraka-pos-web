import 'package:baraka_pos/features/global/data/data.dart';
import 'package:baraka_pos/shared/shared.dart';

import '../../../global/domain/domain.dart';

final class DeviceCollectionDto
    extends JsonCollectionDto<DeviceDto, DeviceCollection, DeviceModel> {
  final Json json;
  DeviceCollectionDto.fromJson(this.json)
      : super.fromJson(
          json,
          (e) => DeviceDto.fromJson(e),
        );
  DeviceCollectionDto.fromList(List list)
      : json = {"data": list},
        super.fromJson(
          {"data": list},
          (e) => DeviceDto.fromJson(e),
        );

  @override
  DeviceCollection collection() {
    return DeviceCollection(
      models: items
          .map(
            (e) => e.model(),
          )
          .toList(),
    );
  }
}
