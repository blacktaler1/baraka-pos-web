part of 'delete_category_bloc.dart';

sealed class DeleteCategoryEvent extends Equatable {
  const DeleteCategoryEvent();

  @override
  List<Object?> get props => [];
}

class DeleteCategoryStarted extends DeleteCategoryEvent {
  final int pk;

  const DeleteCategoryStarted({required this.pk});

  @override
  List<Object?> get props => [pk];
}
