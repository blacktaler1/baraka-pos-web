part of 'delete_product_bloc.dart';

final class DeleteProductEvent extends Equatable {
  final int id;

  const DeleteProductEvent({
    required this.id,
  });

  @override
  List<Object> get props => [];
}
