import 'package:baraka_pos/features/auth/auth.dart';
import 'package:baraka_pos/features/workers/domain/domain.dart';

import 'package:baraka_pos/shared/shared.dart';

final class UserCollectionDto
    extends JsonCollectionDto<UserDto, UserCollection, UserModel> {
  final Json json;

  UserCollectionDto.fromList(List<dynamic> list)
      : json = {'data': list},
        super.fromJson(
          {'data': list},
          (j) => UserDto.fromJson(j),
        );

  @override
  UserCollection collection() {
    return UserCollection(
      models: items.map((e) => e.model()).toList(),
    );
  }
}
