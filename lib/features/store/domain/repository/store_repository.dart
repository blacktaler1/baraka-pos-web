import 'package:baraka_pos/features/global/domain/domain.dart';
import 'package:baraka_pos/features/store/domain/domain.dart';

import '../../../../shared/shared.dart';

abstract class StoreRepository {
  Future<Safed<BaseException, ProductModel>> createProduct({
    required CreateProductPayload payload,
  });

  Future<Safed<BaseException, AllProductModel>> getAllProducts({
    required GetAllProductPayload payload,
  });

  Future<Safed<BaseException, FileBytesModel>> exportProducts({
    required ExportProductsPayload payload,
  });

  Future<Safed<BaseException, ImportResultModel>> importProducts({
    required ImportProductsPayload payload,
  });

  Future<Safed<BaseException, ProductModel>> updateProduct({
    required UpdateProductPayload payload,
  });
  Future<Safed<BaseException, NoContentModel>> deleteProduct({
    required DeleteProductPayload payload,
  });

  Future<Safed<BaseException, ProductModel>> updateStock({
    required StockUpdatePayload payload,
  });

  Future<Safed<BaseException, GeneratedCodeModel>> getGeneratedCode({
    required GeneratedCodePayload payload,
  });

  Future<Safed<BaseException, GlobalProductSearchModel>> globalSearchProduct({
    required GlobalProductPayload payload,
  });
}
