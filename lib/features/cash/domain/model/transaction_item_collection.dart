import 'package:baraka_pos/features/cash/cash.dart';
import 'package:baraka_pos/shared/domain/domain.dart';

final class TransactionItemCollection extends Collection<TransactionItemModel> {
  const TransactionItemCollection({required super.models});

  @override
  List<String> get props => ["collection: $models"];
}
