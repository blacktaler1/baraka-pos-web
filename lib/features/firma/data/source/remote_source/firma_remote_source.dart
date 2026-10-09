import 'package:baraka_pos/shared/aplication/types/json.dart';
import '../../request/update_loan_request.dart';
import 'package:baraka_pos/features/auth/auth.dart';
import 'package:baraka_pos/features/firma/data/data.dart';
import 'package:baraka_pos/features/global/data/data.dart';
import 'package:baraka_pos/shared/data/data.dart';
import '../../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../../../shared/aplication/utils/safed.dart';

final class FirmaRemoteSource extends RemoteSource {
  FirmaRemoteSource({required super.client});

  Future<Safed<BaseException, AllFirmaDto>> getFirma({
    required GetFirmaRequest request,
  }) async {
    return await apiGet(
            path: "/${globalUser?.warehouseUuid}/firma/", request: request)
        .map(
      success: dataFactory(AllFirmaDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, FirmaDto>> createFirma({
    required CreateFirmaRequest request,
  }) async {
    return await apiPost(
            path: "/${globalUser?.warehouseUuid}/firma/", request: request)
        .map(
      success: dataFactory(FirmaDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, FirmaDto>> updateFirma({
    required UpdateFirmaRequest request,
  }) async {
    return await apiPatch(
      path: "/${globalUser?.warehouseUuid}/firma/${request.pk}/",
      request: request,
    ).map(
      success: dataFactory(FirmaDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, FirmaDto>> getByIdFirma({
    required GetByIdFirmaRequest request,
  }) async {
    return await apiGet(
      path: "/${globalUser?.warehouseUuid}/firma/${request.id}/",
      request: request,
    ).map(
      success: dataFactory(FirmaDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, AllLoanDto>> getLoan({
    required GetLoanRequest request,
  }) async {
    return await apiGet(
      path: "/${globalUser?.warehouseUuid}/firma/${request.firmaId}/loans/",
      request: request,
    ).map(
      success: dataFactory(AllLoanDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, LoanFirmaDto>> createLoan({
    required CreateLoanRequest request,
  }) async {
    return await apiPost(
      path: "/${globalUser?.warehouseUuid}/firma/${request.firmaId}/loans/",
      request: request,
    ).map(
      success: dataFactory(LoanFirmaDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, LoanFirmaDto>> payDebt({
    required PayDebtRequest request,
  }) async {
    return await apiPost(
      path:
          "/${globalUser?.warehouseUuid}/firma/${request.firmaId}/loans/${request.debtId}/pay/",
      request: request,
    ).map(
      success: dataFactory(LoanFirmaDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, NoContentDto>> deleteFirma({
    required DeleteFirmaRequest request,
  }) async {
    return await apiDelete(
      path: "/${globalUser?.warehouseUuid}/firma/${request.id}/",
      request: request,
    ).map(
      success: dataFactory(NoContentDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, Json>> updateLoan({
    required int firmaId,
    required int loanId,
    required UpdateLoanRequest request,
  }) {
    return apiPatch(
      path: "/${globalUser?.warehouseUuid}/firma/$firmaId/loans/$loanId/",
      request: request,
    );
  }
}
