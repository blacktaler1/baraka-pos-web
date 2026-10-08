part of 'get_shifts_bloc.dart';

sealed class GetShiftsEvent extends Equatable {
  const GetShiftsEvent();

  @override
  List<Object> get props => [];
}

final class GetShiftsStarted extends GetShiftsEvent {
  final String cursor;
  final int pageSize;
  final String from;
  final String to;

  const GetShiftsStarted({
    required this.cursor,
    required this.pageSize,
    required this.from,
    required this.to,
  });

  @override
  List<Object> get props => [
        "cursor: $cursor",
        "pageSize: $pageSize",
        "from: $from",
        "to: $to",
      ];
}
