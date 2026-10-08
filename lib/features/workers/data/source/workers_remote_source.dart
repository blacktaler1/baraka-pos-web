import 'package:baraka_pos/features/auth/auth.dart';
import 'package:baraka_pos/features/global/global.dart';
import 'package:baraka_pos/features/workers/workers.dart';
import 'package:baraka_pos/shared/shared.dart';

final class WorkersRemoteSource extends RemoteSource {
  WorkersRemoteSource({required super.client});

  Future<Safed<BaseException, GetWorkersDto>> getWorkers({
    required GetWorkersListRequest request,
  }) async {
    return apiGet(path: "/auth/users/", request: request).map(
      success: dataFactory(GetWorkersDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, UserDto>> workerDetails({
    required WorkerDetailRequest request,
  }) async {
    return apiGet(path: "/auth/users/${request.id}/", request: request).map(
      success: dataFactory(UserDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, UserDto>> createUser({
    required CreateWorkerRequest request,
  }) async {
    return apiPost(path: "/auth/users/create/", request: request).map(
      success: dataFactory(UserDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, UserDto>> updateUser({
    required UpdateWorkerRequest request,
  }) async {
    return apiPut(
      request: request,
      path: "/auth/users/${request.id}/",
    ).map(
      success: dataFactory(UserDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, NoContentDto>> deleteUser({
    required DeleteWorkerRequest request,
  }) async {
    return apiDelete(
      request: request,
      path: "/auth/users/${request.id}/delete",
    ).map(
      success: dataFactory(NoContentDto.fromJson),
      failure: (BaseException e) => e,
    );
  }
}
