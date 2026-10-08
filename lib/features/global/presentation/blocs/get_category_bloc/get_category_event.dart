part of 'get_category_bloc.dart';

final class GetCategoryEvent extends Equatable {
  const GetCategoryEvent();

  @override
  List<Object> get props => [];
}

final class GetCategoryStarted extends GetCategoryEvent {
  final String cursor;
  final String pageSize;

  const GetCategoryStarted({
    required this.cursor,
    required this.pageSize,
  });

  @override
  List<Object> get props => [
        "cursor:$cursor",
        "page_size:$pageSize",
      ];
}
