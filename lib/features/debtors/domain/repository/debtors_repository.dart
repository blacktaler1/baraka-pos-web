import 'package:baraka_pos/features/global/domain/model/file_bytes_model.dart';
import 'package:baraka_pos/shared/aplication/aplication.dart';

import '../../debtors.dart';
import '../model/customer_model.dart';

abstract class DebtorsRepository {
  Future<Safed<BaseException, DebtorsListModel>> getDebtorsList({
    required GetDebtorsPayload payload,
  });

  Future<Safed<BaseException, CustomerModel>> createCustomer({
    required CreateCustomerPayload payload,
  });

  Future<Safed<BaseException, GetCustomerModel>> getCustomer({
    required GetCustomerPayload payload,
  });

  Future<Safed<BaseException, ByCustomerModel>> byCustomer({
    required ByCustomerPayload payload,
  });

  Future<Safed<BaseException, PayDebtModel>> payDebt({
    required PayDebtPayload payload,
  });

  Future<Safed<BaseException, PayCustomerDebtsModel>> payCustomerDebts({
    required PayCustomerDebtsPayload payload,
  });

  Future<Safed<BaseException, FileBytesModel>> exportDebtors({
    required ExportDebtorsPayload payload,
  });
  Future<Safed<BaseException, AllCustomerHistoryModel>> byCustomerHistory({
    required ByCustomerHistoryPayload payload,
  });
}
