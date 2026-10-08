import 'package:baraka_pos/features/auth/domain/model/user_model.dart';
import 'package:baraka_pos/features/global/domain/domain.dart';
import 'package:baraka_pos/features/workers/workers.dart';
import 'package:baraka_pos/shared/aplication/exceptions/base_exception.dart';
import 'package:baraka_pos/shared/aplication/utils/safed.dart';

final class WorkersRepositoryImpl extends WorkersRepository {
  final WorkersRemoteSource remote;

  WorkersRepositoryImpl({required this.remote});
  @override
  Future<Safed<BaseException, GetWorkersListModel>> getWorkers({
    required GetWorkersListPayload payload,
  }) async {
    return await remote
        .getWorkers(
          request: GetWorkersListRequest.fromPayload(payload),
        )
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, UserModel>> workerDetail({
    required WorkerDetailPayload payload,
  }) async {
    return await remote
        .workerDetails(
          request: WorkerDetailRequest.fromPayload(payload),
        )
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, UserModel>> createUser({
    required CreateWorkerPayload payload,
  }) async {
    return await remote
        .createUser(
          request: CreateWorkerRequest.fromPayload(payload),
        )
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, UserModel>> updateUser({
    required UpdateWorkerPayload payload,
  }) async {
    return await remote
        .updateUser(
          request: UpdateWorkerRequest.fromPayload(payload),
        )
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, NoContentModel>> deleteUser({
    required DeleteWorkerPayload payload,
  }) async {
    return await remote
        .deleteUser(
          request: DeleteWorkerRequest.fromPayload(payload),
        )
        .map(
          success: (value) => value.model(),
          failure: (BaseException e) => e,
        );
  }
}
