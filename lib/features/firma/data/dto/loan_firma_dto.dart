import 'package:baraka_pos/shared/shared.dart';

import '../../domain/model/loan_firma_model.dart';

final class LoanFirmaDto extends JsonDto<LoanFirmaModel> {
  final Json json;

  const LoanFirmaDto.fromJson(this.json) : super.fromJson(json);

  int get id => json.integer("id");

  String get title => json.text("title");

  String get debt => json.text("debt", fallback: "0");

  String get paid => json.text("paid", fallback: "0");

  String get created => json.text("created");

  @override
  LoanFirmaModel model() {
    return LoanFirmaModel(
      id: id,
      title: title,
      debt: debt,
      paid: paid,
      created: created,
    );
  }
}
