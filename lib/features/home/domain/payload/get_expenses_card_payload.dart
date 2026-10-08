import 'package:baraka_pos/shared/domain/domain.dart';

final class GetExpensesCardPayload extends Payload {
  final String period;

  const GetExpensesCardPayload({required this.period});

  @override
  List<Object> get props => [
        "period: $period",
      ];
}
