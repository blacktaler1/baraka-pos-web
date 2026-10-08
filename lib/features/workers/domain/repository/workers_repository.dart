import 'package:baraka_pos/features/auth/auth.dart';
import 'package:baraka_pos/features/global/domain/domain.dart';
import 'package:baraka_pos/features/workers/domain/domain.dart';
import 'package:baraka_pos/shared/aplication/aplication.dart';

abstract class WorkersRepository {
  Future<Safed<BaseException, GetWorkersListModel>> getWorkers({
    required GetWorkersListPayload payload,
  });

  Future<Safed<BaseException, UserModel>> workerDetail({
    required WorkerDetailPayload payload,
  });

  Future<Safed<BaseException, UserModel>> createUser({
    required CreateWorkerPayload payload,
  });

  Future<Safed<BaseException, UserModel>> updateUser({
    required UpdateWorkerPayload payload,
  });

  Future<Safed<BaseException, NoContentModel>> deleteUser({
    required DeleteWorkerPayload payload,
  });
}
