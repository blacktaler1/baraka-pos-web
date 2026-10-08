import 'package:baraka_pos/shared/shared.dart';

import '../../../auth/presentation/screens/splash_screen.dart';
import '../data.dart';

final class InventoryRemoteSource extends RemoteSource {
  InventoryRemoteSource({required super.client});

  String get _base => "/${globalUser?.warehouseUuid}/inventory";

  Future<Safed<BaseException, GetReceiptsDto>> getReceipts({
    required GetReceiptsRequest request,
  }) async {
    return await apiGet(path: "$_base/receipts/", request: request).map(
      success: (json) => GetReceiptsDto.fromJson(json),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, ReceiptDto>> createReceipt({
    required CreateReceiptRequest request,
  }) async {
    return await apiPost(path: "$_base/receipts/", request: request).map(
      success: (json) => ReceiptDto.fromJson(json),
      failure: (BaseException e) => e,
    );
  }

  /// Nakladnoy rasmini AI orqali o'qish — javob 1 daqiqagacha cho'zilishi mumkin
  Future<Safed<BaseException, InvoiceScanDto>> scanInvoice({
    required ScanInvoiceRequest request,
  }) async {
    return await apiPost(
      path: "$_base/receipts/scan-invoice/",
      request: request,
      receiveTimeout: const Duration(seconds: 120),
    ).map(
      success: (json) => InvoiceScanDto.fromJson(json),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, GetWriteOffsDto>> getWriteOffs({
    required GetWriteOffsRequest request,
  }) async {
    return await apiGet(path: "$_base/write-offs/", request: request).map(
      success: (json) => GetWriteOffsDto.fromJson(json),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, CreatedWriteOffsDto>> createWriteOff({
    required CreateWriteOffRequest request,
  }) async {
    return await apiPost(path: "$_base/write-offs/", request: request).map(
      success: (json) => CreatedWriteOffsDto.fromJson(json),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, GetInventoryCountsDto>> getInventoryCounts({
    required GetInventoryCountsRequest request,
  }) async {
    return await apiGet(path: "$_base/counts/", request: request).map(
      success: (json) => GetInventoryCountsDto.fromJson(json),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, InventoryCountDto>> getInventoryCount({
    required GetInventoryCountRequest request,
  }) async {
    return await apiGet(path: "$_base/counts/${request.id}/", request: request)
        .map(
      success: (json) => InventoryCountDto.fromJson(json),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, InventoryCountDto>> createInventoryCount({
    required CreateInventoryCountRequest request,
  }) async {
    return await apiPost(path: "$_base/counts/", request: request).map(
      success: (json) => InventoryCountDto.fromJson(json),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, InventoryCountDto>> addInventoryItem({
    required AddInventoryItemRequest request,
  }) async {
    return await apiPost(
            path: "$_base/counts/${request.countId}/items/", request: request)
        .map(
      success: (json) => InventoryCountDto.fromJson(json),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, InventoryCountDto>> removeInventoryItem({
    required RemoveInventoryItemRequest request,
  }) async {
    return await apiDelete(
            path: "$_base/counts/${request.countId}/items/${request.itemId}/",
            request: request)
        .map(
      success: (json) => InventoryCountDto.fromJson(json),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, InventoryCountDto>> completeInventoryCount({
    required CompleteInventoryCountRequest request,
  }) async {
    return await apiPost(
            path: "$_base/counts/${request.id}/complete/", request: request)
        .map(
      success: (json) => InventoryCountDto.fromJson(json),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, InventoryCountDto>> cancelInventoryCount({
    required CancelInventoryCountRequest request,
  }) async {
    return await apiPost(
            path: "$_base/counts/${request.id}/cancel/", request: request)
        .map(
      success: (json) => InventoryCountDto.fromJson(json),
      failure: (BaseException e) => e,
    );
  }
}
