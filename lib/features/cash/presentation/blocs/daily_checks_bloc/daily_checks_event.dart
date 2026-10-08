part of 'daily_checks_bloc.dart';

final class DailyChecksEvent extends Equatable {
  const DailyChecksEvent();

  @override
  List<Object> get props => [];
}

final class DailyChecksStarted extends DailyChecksEvent {
  final String from;
  final String to;

  const DailyChecksStarted({
    required this.from,
    required this.to,
  });

  @override
  List<Object> get props => [
        "from: $from",
        "to: $to",
      ];
}
