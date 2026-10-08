part of 'update_category_bloc.dart';

sealed class UpdateCategoryEvent extends Equatable {
  const UpdateCategoryEvent();

  @override
  List<Object?> get props => [];
}

class UpdateCategoryStarted extends UpdateCategoryEvent {
  final int pk;
  final String title;
  final List list;

  const UpdateCategoryStarted({
    required this.pk,
    required this.title,
    required this.list,
  });

  @override
  List<Object?> get props => [pk, title, list];
}
