import 'package:baraka_pos/features/firma/domain/domain.dart';
import 'package:baraka_pos/shared/aplication/aplication.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../auth/data/dto/image_collection_dto.dart';
import '../../../auth/domain/model/image_collection.dart';

final class FirmaDto extends JsonDto<FirmaModel> {
  final Json json;

  FirmaDto.fromJson(this.json) : super.fromJson(json);

  int get id => json.integer('id');

  String get title => json.text('title');

  String get phone => json.text('phone');

  String get address => json.text('address');

  int get warehouse => json.integer('warehouse');

  ImageCollection get images =>
      ImageCollectionDto.fromList(json.items("images")).collection();

  String get created => json.text('created');

  String get modified => json.text('modified');

  String get deletedAt => json.text('deleted_at');

  int get totalProducts => json.integer('total_products');

  num get totalDebt => json.number('total_debt');

  num get totalPaid => json.number('total_paid');

  num get remainder => json.number('remainder');

  @override
  FirmaModel model() {
    return FirmaModel(
      id: id,
      title: title,
      phone: phone,
      address: address,
      warehouse: warehouse,
      images: images,
      created: created,
      modified: modified,
      deletedAt: deletedAt,
      totalProducts: totalProducts,
      totalDebt: totalDebt,
      totalPaid: totalPaid,
      remainder: remainder,
    );
  }
}
