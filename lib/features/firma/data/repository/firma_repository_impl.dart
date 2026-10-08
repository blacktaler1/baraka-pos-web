import 'package:baraka_pos/features/firma/data/request/_request.dart';
import 'package:baraka_pos/features/firma/domain/domain.dart';
import 'package:baraka_pos/features/global/domain/model/no_content_model.dart';
import 'package:baraka_pos/shared/aplication/exceptions/base_exception.dart';
import 'package:baraka_pos/shared/aplication/utils/safed.dart';

import '../source/remote_source/firma_remote_source.dart';

final class FirmaRepositoryImpl extends FirmaRepository {
  final FirmaRemoteSource remote;

  FirmaRepositoryImpl({
    required this.remote,
  });

  @override
  Future<Safed<BaseException, AllFirmaModel>> getFirma({
    required GetFirmaPayload payload,
  }) async {
    final result = await remote.getFirma(
      request: GetFirmaRequest.fromPayload(payload),
    );
    return result.map(
      success: (dto) {
        return dto.model();
      },
      failure: (e) {
        throw e;
      },
    );
  }

  @override
  Future<Safed<BaseException, FirmaModel>> createFirma(
      {required CreateFirmaPayload payload}) async {
    final result = await remote.createFirma(
        request: CreateFirmaRequest.fromPayload(payload));
    return result.map(success: (dto) {
      return dto.model();
    }, failure: (e) {
      throw e;
    });
  }

  @override
  Future<Safed<BaseException, FirmaModel>> updateFirma(
      {required UpdateFirmaPayload payload}) async {
    final result = await remote.updateFirma(
        request: UpdateFirmaRequest.fromPayload(payload));
    return result.map(success: (dto) {
      return dto.model();
    }, failure: (e) {
      throw e;
    });
  }

  @override
  Future<Safed<BaseException, FirmaModel>> getByIdFirma(
      {required GetByIdFirmaPayload payload}) async {
    final result = await remote.getByIdFirma(
        request: GetByIdFirmaRequest.fromPayload(payload));
    return result.map(success: (dto) {
      return dto.model();
    }, failure: (e) {
      throw e;
    });
  }

  @override
  Future<Safed<BaseException, AllLoanModel>> getLoan(
      {required GetLoanPayload payload}) async {
    final result =
        await remote.getLoan(request: GetLoanRequest.fromPayload(payload));
    return result.map(success: (dto) {
      return dto.model();
    }, failure: (e) {
      throw e;
    });
  }

  @override
  Future<Safed<BaseException, LoanFirmaModel>> createLoan({
    required CreateLoanPayload payload,
  }) async {
    final result = await remote.createLoan(
        request: CreateLoanRequest.fromPayload(payload));
    return result.map(success: (dto) {
      return dto.model();
    }, failure: (e) {
      throw e;
    });
  }

  @override
  Future<Safed<BaseException, LoanFirmaModel>> payDebt({
    required LoanFirmaPayload payload,
  }) async {
    final result = await remote.payDebt(
      request: PayDebtRequest.fromPayload(payload),
    );
    return result.map(success: (dto) {
      return dto.model();
    }, failure: (e) {
      throw e;
    });
  }

  @override
  Future<Safed<BaseException, NoContentModel>> deleteFirma({
    required DeleteFirmaPayload payload,
  }) async {
    return await remote
        .deleteFirma(request: DeleteFirmaRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }
}
