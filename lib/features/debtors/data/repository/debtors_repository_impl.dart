import '../../domain/payload/update_debt_record_payload.dart';
import '../request/update_debt_record_request.dart';
import 'package:baraka_pos/features/global/domain/model/file_bytes_model.dart';
import '../../../../shared/shared.dart';
import '../../debtors.dart';
import '../../domain/model/customer_model.dart';

final class DebtorsRepositoryImpl extends DebtorsRepository {
  final DebtorRemouteSource remote;

  DebtorsRepositoryImpl({required this.remote});

  @override
  Future<Safed<BaseException, DebtorsListModel>> getDebtorsList({
    required GetDebtorsPayload payload,
  }) async {
    return remote
        .getDebtorList(
          request: GetDebtorsRequest.fromPayload(payload),
        )
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, CustomerModel>> createCustomer({
    required CreateCustomerPayload payload,
  }) async {
    return remote
        .createCustomer(
          request: CreateCustomerRequest.fromPayload(payload),
        )
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, GetCustomerModel>> getCustomer({
    required GetCustomerPayload payload,
  }) async {
    return remote
        .getCustomer(
          request: GetCustomerRequest.fromPayload(payload),
        )
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, ByCustomerModel>> byCustomer({
    required ByCustomerPayload payload,
  }) async {
    return await remote
        .byCustomer(request: ByCustomerRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, PayDebtModel>> payDebt({
    required PayDebtPayload payload,
  }) async {
    return await remote
        .payDebt(
          request: PayDebtRequest.fromPayload(payload),
        )
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, PayCustomerDebtsModel>> payCustomerDebts({
    required PayCustomerDebtsPayload payload,
  }) async {
    return await remote
        .payCustomerDebts(
          request: PayCustomerDebtsRequest.fromPayload(payload),
        )
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, FileBytesModel>> exportDebtors({
    required ExportDebtorsPayload payload,
  }) async {
    return await remote
        .exportDebtors(
          request: ExportDebtorsRequest.fromPayload(payload),
        )
        .map(
          success: (bytes) => FileBytesModel(bytes: bytes),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, AllCustomerHistoryModel>> byCustomerHistory({
    required ByCustomerHistoryPayload payload,
  }) async {
    return await remote
        .byCustomerHistory(
          request: ByCustomerHistoryRequest.fromPayload(payload),
        )
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, Json>> updateDebtRecord({
    required UpdateDebtRecordPayload payload,
  }) {
    return remote.updateDebtRecord(
      recordId: payload.recordId,
      request: UpdateDebtRecordRequest.fromPayload(payload),
    );
  }
}
