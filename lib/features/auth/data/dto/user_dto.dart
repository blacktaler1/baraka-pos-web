import 'package:baraka_pos/features/auth/data/dto/warehouse_dto.dart';
import 'package:baraka_pos/features/auth/domain/domain.dart';
import 'package:baraka_pos/shared/shared.dart';

import 'package:baraka_pos/features/workers/domain/model/worker_permissions.dart';

import 'image_collection_dto.dart';

final class UserDto extends JsonDto<UserModel> {
  final Json json;

  UserDto.fromJson(this.json) : super.fromJson(json);

  int get id => json.integer("id");
  String get name => json.text("name");
  String get role => json.text("role");
  String get code => json.text("code");
  String get phone => json.text("phone");
  String get limit => json.text("limit");
  String get dateJoined => json.text("date_joined");
  bool get limitExceeded => json.flag("limit_exceeded");
  ImageCollection get images =>
      ImageCollectionDto.fromList(json.items("images")).collection();

  WarehouseModel get warehouse =>
      WarehouseDto.fromJson(json.object("warehouse")).model();

  WorkerPermissions get permissions {
    final source =
        json.containsKey("permissions") ? json.object("permissions") : json;
    return WorkerPermissions(
      canDiscount: source.flag("can_discount"),
      maxDiscountPercent: source.decimal("max_discount_percent"),
      canEditPrice: source.flag("can_edit_price", fallback: true),
      canRefund: source.flag("can_refund", fallback: true),
    );
  }

  @override
  UserModel model() {
    return UserModel(
      id: id,
      name: name,
      role: role,
      code: code,
      phone: phone,
      limit: limit,
      dateJoined: dateJoined,
      limitExceeded: limitExceeded,
      images: images,
      warehouse: warehouse,
      permissions: permissions,
    );
  }
}
