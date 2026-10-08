import 'package:baraka_pos/features/cash/cash.dart';
import 'package:baraka_pos/shared/domain/domain.dart';

final class TransactionCollection extends Collection<TransactionModel> {
  const TransactionCollection({required super.models});

  @override
  List<String> get props => ["collection: $models"];
}
