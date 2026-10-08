import 'package:baraka_pos/shared/aplication/aplication.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/domain.dart';
import 'dto.dart';

final class GetReceiptsDto extends JsonDto<GetReceiptsModel> {
  final Json json;

  const GetReceiptsDto.fromJson(this.json) : super.fromJson(json);

  @override
  GetReceiptsModel model() {
    return GetReceiptsModel(
      next: json.text("next"),
      previous: json.text("previous"),
      total: json.integer("total"),
      data: ReceiptCollectionDto.fromList(json.items("data")).collection(),
    );
  }
}
