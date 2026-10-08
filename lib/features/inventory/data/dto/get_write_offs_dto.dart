import 'package:baraka_pos/shared/aplication/aplication.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/domain.dart';
import 'dto.dart';

final class GetWriteOffsDto extends JsonDto<GetWriteOffsModel> {
  final Json json;

  const GetWriteOffsDto.fromJson(this.json) : super.fromJson(json);

  @override
  GetWriteOffsModel model() {
    return GetWriteOffsModel(
      next: json.text("next"),
      previous: json.text("previous"),
      total: json.integer("total"),
      data: WriteOffCollectionDto.fromList(json.items("data")).collection(),
    );
  }
}
