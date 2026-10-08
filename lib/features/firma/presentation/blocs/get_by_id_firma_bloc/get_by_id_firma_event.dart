part of 'get_by_id_firma_bloc.dart';

sealed class GetByIdFirmaEvent extends Equatable {
  const GetByIdFirmaEvent();

  @override
  List<Object> get props => [];
}

final class GetByIdFirmaStarted extends GetByIdFirmaEvent {
  final int id;

  const GetByIdFirmaStarted({
    required this.id,
  });

  @override
  List<Object> get props => [
        "id: $id",
      ];
}
