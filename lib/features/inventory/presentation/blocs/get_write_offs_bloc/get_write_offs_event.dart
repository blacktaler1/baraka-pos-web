part of 'get_write_offs_bloc.dart';

sealed class GetWriteOffsEvent extends Equatable {
  const GetWriteOffsEvent();

  @override
  List<Object> get props => [];
}

final class GetWriteOffsStarted extends GetWriteOffsEvent {
  final String cursor;
  final int pageSize;

  const GetWriteOffsStarted({
    required this.cursor,
    required this.pageSize,
  });

  @override
  List<Object> get props => [
        "cursor: $cursor",
        "pageSize: $pageSize",
      ];
}
