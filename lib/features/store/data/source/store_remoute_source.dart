import 'dart:typed_data';

import 'package:baraka_pos/features/auth/auth.dart';
import 'package:baraka_pos/features/global/data/data.dart';
import 'package:baraka_pos/shared/shared.dart';
import '../data.dart';

final class StoreRemouteSource extends RemoteSource {
  StoreRemouteSource({required super.client});

  Future<Safed<BaseException, ProductDto>> createProduct({
    required CreateProductRequest request,
  }) async {
    return await apiPost(
      path: "/${globalUser?.warehouseUuid}/product/",
      request: request,
    ).map(
      success: dataFactory(ProductDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, Uint8List>> exportProducts({
    required ExportProductsRequest request,
  }) async {
    return await apiDownload(
      path: "/${globalUser?.warehouseUuid}/product/export/",
      request: request,
    );
  }

  Future<Safed<BaseException, ImportResultDto>> importProducts({
    required ImportProductsRequest request,
  }) async {
    return await apiPost(
      path: "/${globalUser?.warehouseUuid}/product/import/",
      request: request,
    ).map(
      success: dataFactory(ImportResultDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, ProductDto>> updateProduct({
    required UpdateProductRequest request,
  }) async {
    return await apiPatch(
      path: "/${globalUser?.warehouseUuid}/product/${request.id}/",
      request: request,
    ).map(
      success: dataFactory(ProductDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, AllProductDto>> getAllProduct({
    required AllProductRequest request,
  }) async {
    return await apiGet(
            path: "/${globalUser?.warehouseUuid}/product/", request: request)
        .map(
      success: dataFactory(AllProductDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, NoContentDto>> deleteProduct({
    required DeleteProductRequest request,
  }) async {
    return await apiDelete(
      path: "/${globalUser?.warehouseUuid}/product/${request.id}/",
      request: request,
    ).map(
      success: dataFactory(NoContentDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, ProductDto>> updateStock({
    required StockUpdateRequest request,
  }) async {
    return await apiPost(
      path: "/${globalUser?.warehouseUuid}/product/${request.pk}/stock/",
      request: request,
    ).map(
      success: dataFactory(ProductDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, GeneratedCodeDto>> getGeneratedCode({
    required GeneratedCodeRequest request,
  }) async {
    return await apiGet(
            path: "/${globalUser?.warehouseUuid}/product/generate-code/",
            request: request)
        .map(
      success: dataFactory(GeneratedCodeDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, GlobalProductSearchDto>> globalProductSearch({
    required GlobalProductSearchRequest request,
  }) async {
    return await apiGet(
      path:
          "/${globalUser?.warehouseUuid}/product/search/?search=${request.search}",
      request: request,
    ).map(
      success: dataFactory(GlobalProductSearchDto.fromJson),
      failure: (BaseException e) => e,
    );
  }
}
