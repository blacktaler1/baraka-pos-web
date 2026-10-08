import 'package:baraka_pos/features/global/domain/model/category_collection.dart';
import 'package:baraka_pos/shared/domain/domain.dart';

final class GetCategoryModel extends Model {
  final String next;
  final String previous;
  final int total;
  final CategoryCollection collection;

  const GetCategoryModel({
    required this.collection,
    required this.next,
    required this.previous,
    required this.total,
  });

  @override
  List<String> get props => [
        "next: $next",
        "previous: $previous",
        "total: $total",
        "data: $collection",
      ];
}
