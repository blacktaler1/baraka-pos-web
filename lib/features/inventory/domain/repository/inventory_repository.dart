import 'package:baraka_pos/shared/shared.dart';

import '../domain.dart';

abstract class InventoryRepository {
  Future<Safed<BaseException, GetReceiptsModel>> getReceipts({
    required GetReceiptsPayload payload,
  });

  Future<Safed<BaseException, ReceiptModel>> createReceipt({
    required CreateReceiptPayload payload,
  });

  Future<Safed<BaseException, InvoiceScanModel>> scanInvoice({
    required ScanInvoicePayload payload,
  });

  Future<Safed<BaseException, GetWriteOffsModel>> getWriteOffs({
    required GetWriteOffsPayload payload,
  });

  Future<Safed<BaseException, WriteOffCollection>> createWriteOff({
    required CreateWriteOffPayload payload,
  });

  Future<Safed<BaseException, GetInventoryCountsModel>> getInventoryCounts({
    required GetInventoryCountsPayload payload,
  });

  Future<Safed<BaseException, InventoryCountModel>> getInventoryCount({
    required GetInventoryCountPayload payload,
  });

  Future<Safed<BaseException, InventoryCountModel>> createInventoryCount({
    required CreateInventoryCountPayload payload,
  });

  Future<Safed<BaseException, InventoryCountModel>> addInventoryItem({
    required AddInventoryItemPayload payload,
  });

  Future<Safed<BaseException, InventoryCountModel>> removeInventoryItem({
    required RemoveInventoryItemPayload payload,
  });

  Future<Safed<BaseException, InventoryCountModel>> completeInventoryCount({
    required CompleteInventoryCountPayload payload,
  });

  Future<Safed<BaseException, InventoryCountModel>> cancelInventoryCount({
    required CancelInventoryCountPayload payload,
  });
}
