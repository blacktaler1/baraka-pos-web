part of 'global_product_search_bloc.dart';

final class GlobalProductSearchEvent extends Equatable {
  final String search;

  const GlobalProductSearchEvent({required this.search});

  @override
  List<Object> get props => ["search: $search"];
}
