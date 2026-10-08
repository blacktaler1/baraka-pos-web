part of 'get_worker_list_bloc.dart';

sealed class GetWorkerListEvent extends Equatable {
  const GetWorkerListEvent();

  @override
  List<Object> get props => [];
}

final class GetWorkerListStarted extends GetWorkerListEvent {
  const GetWorkerListStarted();
}
