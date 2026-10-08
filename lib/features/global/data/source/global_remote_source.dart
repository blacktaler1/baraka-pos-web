import 'package:baraka_pos/features/global/global.dart';
import 'package:baraka_pos/shared/aplication/aplication.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../auth/presentation/screens/splash_screen.dart';

final class GlobalRemoteSource extends RemoteSource {
  GlobalRemoteSource({required super.client});

  Future<Safed<BaseException, GetCategoryDto>> getCategory({
    required GetCategoryRequest request,
  }) async {
    return await apiGet(
            path: "/${globalUser?.warehouseUuid}/category/", request: request)
        .map(
      success: dataFactory(GetCategoryDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, CategoryDto>> createCategory({
    required CreateCategoryRequest request,
  }) async {
    return await apiPost(
      path: "/${globalUser?.warehouseUuid}/category/",
      request: request,
    ).map(
      success: dataFactory(CategoryDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, CategoryDto>> updateCategory({
    required UpdateCategoryRequest request,
  }) async {
    return await apiPatch(
      path: "/${globalUser?.warehouseUuid}/category/${request.pk}/",
      request: request,
    ).map(
      success: dataFactory(CategoryDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, DeleteCategoryDto>> deleteCategory({
    required DeleteCategoryRequest request,
  }) async {
    return await apiDelete(
      path: "/${globalUser?.warehouseUuid}/category/${request.pk}/",
      request: request,
    ).map(
        success: dataFactory(DeleteCategoryDto.fromJson),
        failure: (BaseException e) => e);
  }
}
