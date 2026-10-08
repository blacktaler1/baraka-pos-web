import 'package:baraka_pos/features/firma/domain/domain.dart';
import 'package:baraka_pos/shared/shared.dart';

import 'loan_firma_collection_dto.dart';

final class AllLoanDto extends JsonDto<AllLoanModel> {
  final Json json;

  const AllLoanDto.fromJson(this.json) : super.fromJson(json);

  String get next => json["next"] ?? "";

  String get previous => json["previous"] ?? "";

  int get total => json.integer("total");

  LoanFirmaCollection get data {
    final raw = json["data"];
    return LoanFirmaCollectionDto.fromList(raw is List ? raw : []).collection();
  }

  @override
  AllLoanModel model() => AllLoanModel(
        next: next,
        previous: previous,
        total: total,
        data: data,
      );
}
