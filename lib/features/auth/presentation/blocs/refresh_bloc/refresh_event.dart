part of 'refresh_bloc.dart';

sealed class RefreshEvent extends Equatable {
  const RefreshEvent();

  @override
  List<Object> get props => [];
}

final class RefreshStarted extends RefreshEvent {
  final String refresh;

  const RefreshStarted({required this.refresh});

  @override
  List<Object> get props => [
        "refresh: $refresh",
      ];
}
