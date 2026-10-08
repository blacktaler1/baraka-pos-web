part of 'delete_firma_bloc.dart';

final class DeleteFirmaEvent extends Equatable {
  final int id;
  const DeleteFirmaEvent({required this.id});

  @override
  List<Object> get props => [
        "id: $id",
      ];
}
