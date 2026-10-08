import 'package:baraka_pos/shared/domain/domain.dart';

final class CardItemModel extends Model {
  final num value;
  final num pct;

  const CardItemModel({
    required this.value,
    required this.pct,
  });

  /// UI uchun tayyor foiz (10.0 -> 10)
  int get pctInt => pct.toInt();

  /// Agar string ko‘rinish kerak bo‘lsa
  String get pctText => "${pctInt}%";

  @override
  List<String> get props => [
        "value: $value",
        "pct: $pct",
      ];
}
