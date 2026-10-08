import 'package:baraka_pos/features/global/domain/domain.dart';

import '../../../../shared/shared.dart';

abstract class GlobalRepository {
  Future<Safed<BaseException, GetCategoryModel>> getCategory({
    required CategoryPayload payload,
  });

  Future<Safed<BaseException, CategoryModel>> createCategory({
    required CreateCategoryPayload payload,
  });
  Future<Safed<BaseException, CategoryModel>> updateCategory({
    required UpdateCategoryPayload payload,
  });
  Future<Safed<BaseException, DeleteCategoryModel>> deleteCategory({
    required DeleteCategoryPayload payload,
  });
}
