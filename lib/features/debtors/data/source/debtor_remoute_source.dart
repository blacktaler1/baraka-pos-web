import 'dart:typed_data';

import 'package:baraka_pos/features/auth/presentation/presentation.dart';
import 'package:baraka_pos/features/debtors/data/dto/customer_dto.dart';
import 'package:baraka_pos/features/debtors/data/dto/get_customer_dto.dart';
import 'package:baraka_pos/shared/aplication/aplication.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../debtors.dart';

final class DebtorRemouteSource extends RemoteSource {
  DebtorRemouteSource({required super.client});

  Future<Safed<BaseException, DebtorsListDto>> getDebtorList({
    required GetDebtorsRequest request,
  }) async {
    return await apiGet(
      path: "/${globalUser?.warehouseUuid}/debts/summary/",
      request: request,
    ).map(
      success: dataFactory(DebtorsListDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, GetCustomerDto>> getCustomer({
    required GetCustomerRequest request,
  }) async {
    return await apiGet(
      path: "/${globalUser?.warehouseUuid}/debts/",
      request: request,
    ).map(
      success: dataFactory(GetCustomerDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, CustomerDto>> createCustomer({
    required CreateCustomerRequest request,
  }) {
    return apiPost(
      path: "/${globalUser?.warehouseUuid}/debts/",
      request: request,
    ).map(
      success: dataFactory(CustomerDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, ByCustomerDto>> byCustomer({
    required ByCustomerRequest request,
  }) {
    return apiGet(
      path: "/${globalUser?.warehouseUuid}/debts/${request.id}/history/",
      request: request,
    ).map(
      success: dataFactory(ByCustomerDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, AllCustomerHistoryDto>> byCustomerHistory({
    required ByCustomerHistoryRequest request,
  }) {
    return apiGet(
      path: "/${globalUser?.warehouseUuid}/debts/${request.id}/history/",
      request: request,
    ).map(
      success: dataFactory(AllCustomerHistoryDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, PayDebtDto>> payDebt({
    required PayDebtRequest request,
  }) {
    return apiPost(
      path: "/${globalUser?.warehouseUuid}/debts/pay/",
      request: request,
    ).map(
      success: dataFactory(PayDebtDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, PayCustomerDebtsDto>> payCustomerDebts({
    required PayCustomerDebtsRequest request,
  }) {
    return apiPost(
      path:
          "/${globalUser?.warehouseUuid}/debts/${request.customerId}/pay-all/",
      request: request,
    ).map(
      success: dataFactory(PayCustomerDebtsDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, Uint8List>> exportDebtors({
    required ExportDebtorsRequest request,
  }) {
    return apiDownload(
      path: "/${globalUser?.warehouseUuid}/debts/summary/export/",
      request: request,
    );
  }
}
