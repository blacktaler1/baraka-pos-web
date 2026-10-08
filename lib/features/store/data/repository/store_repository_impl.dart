import 'package:baraka_pos/features/store/store.dart';
import 'package:baraka_pos/shared/aplication/exceptions/base_exception.dart';
import 'package:baraka_pos/shared/aplication/utils/safed.dart';

import '../../../global/global.dart';

final class StoreRepositoryImpl extends StoreRepository {
  final StoreRemouteSource remote;

  StoreRepositoryImpl({required this.remote});

  @override
  Future<Safed<BaseException, ProductModel>> createProduct({
    required CreateProductPayload payload,
  }) async {
    return await remote
        .createProduct(
          request: CreateProductRequest.fromPayload(payload),
        )
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, AllProductModel>> getAllProducts({
    required GetAllProductPayload payload,
  }) async {
    return await remote
        .getAllProduct(
          request: AllProductRequest.fromPayload(payload),
        )
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, FileBytesModel>> exportProducts({
    required ExportProductsPayload payload,
  }) async {
    return await remote
        .exportProducts(
          request: ExportProductsRequest.fromPayload(payload),
        )
        .map(
          success: (bytes) => FileBytesModel(bytes: bytes),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, ImportResultModel>> importProducts({
    required ImportProductsPayload payload,
  }) async {
    return await remote
        .importProducts(
          request: ImportProductsRequest.fromPayload(payload),
        )
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, ProductModel>> updateProduct({
    required UpdateProductPayload payload,
  }) async {
    return await remote
        .updateProduct(
          request: UpdateProductRequest.fromPayload(payload),
        )
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, NoContentModel>> deleteProduct({
    required DeleteProductPayload payload,
  }) async {
    return await remote
        .deleteProduct(
          request: DeleteProductRequest.fromPayload(payload),
        )
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, ProductModel>> updateStock({
    required StockUpdatePayload payload,
  }) async {
    return await remote
        .updateStock(
          request: StockUpdateRequest.fromPayload(payload),
        )
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, GeneratedCodeModel>> getGeneratedCode({
    required GeneratedCodePayload payload,
  }) async {
    return await remote
        .getGeneratedCode(
          request: GeneratedCodeRequest.fromPayload(payload),
        )
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, GlobalProductSearchModel>> globalSearchProduct({
    required GlobalProductPayload payload,
  }) {
    return remote
        .globalProductSearch(
            request: GlobalProductSearchRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }
}
