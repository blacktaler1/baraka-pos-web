import '../../../../shared/domain/domain.dart';
import 'product_collection.dart';

final class AllProductModel extends Model {
  final String next;
  final String previous;
  final int total;
  final AllProductCollectionModel collection;
  final num totalStockValue;

  const AllProductModel({
    required this.next,
    required this.previous,
    required this.total,
    required this.collection,
    required this.totalStockValue,
  });

  @override
  List<String> get props => [
        "next: $next",
        "previous: $previous",
        "total: $total",
        "data: $collection",
        "total_stock_value: $totalStockValue",
      ];
}
