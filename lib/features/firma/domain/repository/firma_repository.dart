import 'package:baraka_pos/shared/aplication/types/json.dart';
import '../payload/update_loan_payload.dart';
import 'package:baraka_pos/features/firma/domain/domain.dart';
import 'package:baraka_pos/features/global/global.dart';

import '../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../../shared/aplication/utils/safed.dart';

abstract class FirmaRepository {
  Future<Safed<BaseException, AllFirmaModel>> getFirma({
    required GetFirmaPayload payload,
  });

  Future<Safed<BaseException, FirmaModel>> createFirma({
    required CreateFirmaPayload payload,
  });

  Future<Safed<BaseException, FirmaModel>> updateFirma({
    required UpdateFirmaPayload payload,
  });

  Future<Safed<BaseException, FirmaModel>> getByIdFirma({
    required GetByIdFirmaPayload payload,
  });
  Future<Safed<BaseException, AllLoanModel>> getLoan({
    required GetLoanPayload payload,
  });
  Future<Safed<BaseException, LoanFirmaModel>> createLoan({
    required CreateLoanPayload payload,
  });

  Future<Safed<BaseException, LoanFirmaModel>> payDebt({
    required LoanFirmaPayload payload,
  });
  Future<Safed<BaseException, NoContentModel>> deleteFirma({
    required DeleteFirmaPayload payload,
  });

  /// Firma qarzining tavsifi yoki qolgan summasini o'zgartirish
  Future<Safed<BaseException, Json>> updateLoan({
    required UpdateLoanPayload payload,
  });
}
