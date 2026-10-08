part of 'create_category_bloc.dart';

final class CreateCategoryEvent extends Equatable {
  final String title;
  final List list;

  const CreateCategoryEvent({
    required this.list,
    required this.title,
  });

  @override
  List<Object> get props => [
        "list: $list",
        "title: $title",
      ];
}
