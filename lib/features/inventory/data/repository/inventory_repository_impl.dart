import 'package:baraka_pos/shared/shared.dart';

import '../../domain/domain.dart';
import '../data.dart';

final class InventoryRepositoryImpl extends InventoryRepository {
  final InventoryRemoteSource remote;

  InventoryRepositoryImpl({required this.remote});

  @override
  Future<Safed<BaseException, GetReceiptsModel>> getReceipts({
    required GetReceiptsPayload payload,
  }) async {
    return await remote
        .getReceipts(request: GetReceiptsRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, ReceiptModel>> createReceipt({
    required CreateReceiptPayload payload,
  }) async {
    return await remote
        .createReceipt(request: CreateReceiptRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, InvoiceScanModel>> scanInvoice({
    required ScanInvoicePayload payload,
  }) async {
    return await remote
        .scanInvoice(request: ScanInvoiceRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, GetWriteOffsModel>> getWriteOffs({
    required GetWriteOffsPayload payload,
  }) async {
    return await remote
        .getWriteOffs(request: GetWriteOffsRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, WriteOffCollection>> createWriteOff({
    required CreateWriteOffPayload payload,
  }) async {
    return await remote
        .createWriteOff(request: CreateWriteOffRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, GetInventoryCountsModel>> getInventoryCounts({
    required GetInventoryCountsPayload payload,
  }) async {
    return await remote
        .getInventoryCounts(
            request: GetInventoryCountsRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, InventoryCountModel>> getInventoryCount({
    required GetInventoryCountPayload payload,
  }) async {
    return await remote
        .getInventoryCount(
            request: GetInventoryCountRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, InventoryCountModel>> createInventoryCount({
    required CreateInventoryCountPayload payload,
  }) async {
    return await remote
        .createInventoryCount(
            request: CreateInventoryCountRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, InventoryCountModel>> addInventoryItem({
    required AddInventoryItemPayload payload,
  }) async {
    return await remote
        .addInventoryItem(request: AddInventoryItemRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, InventoryCountModel>> removeInventoryItem({
    required RemoveInventoryItemPayload payload,
  }) async {
    return await remote
        .removeInventoryItem(
            request: RemoveInventoryItemRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, InventoryCountModel>> completeInventoryCount({
    required CompleteInventoryCountPayload payload,
  }) async {
    return await remote
        .completeInventoryCount(
            request: CompleteInventoryCountRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, InventoryCountModel>> cancelInventoryCount({
    required CancelInventoryCountPayload payload,
  }) async {
    return await remote
        .cancelInventoryCount(
            request: CancelInventoryCountRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }
}
