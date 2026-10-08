import 'package:baraka_pos/features/workers/data/data.dart';
import 'package:baraka_pos/features/workers/domain/domain.dart';

import '../../../../shared/shared.dart';

final class GetWorkersDto extends JsonDto<GetWorkersListModel> {
  final Json json;

  GetWorkersDto.fromJson(this.json) : super.fromJson(json);

  // String get next => json["next"];

  // String get previus => json["previus"];

  UserCollection get userCollection =>
      UserCollectionDto.fromList(json["results"] ?? []).collection();

  @override
  GetWorkersListModel model() {
    return GetWorkersListModel(
      next: "next",
      userCollection: userCollection,
      previus: "previus",
    );
  }
}
