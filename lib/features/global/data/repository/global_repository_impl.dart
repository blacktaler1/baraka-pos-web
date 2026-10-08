import 'package:baraka_pos/features/global/global.dart';
import 'package:baraka_pos/shared/aplication/configs/logger/talker_logger.dart';
import 'package:baraka_pos/shared/aplication/exceptions/base_exception.dart';
import 'package:baraka_pos/shared/aplication/utils/safed.dart';

final class GlobalRepositoryImpl extends GlobalRepository {
  final GlobalRemoteSource remote;
  final CategoryLocalSource local;

  GlobalRepositoryImpl({
    required this.remote,
    required this.local,
  });

  @override
  Future<Safed<BaseException, GetCategoryModel>> getCategory({
    required CategoryPayload payload,
  }) async {
    final result = await remote.getCategory(
      request: GetCategoryRequest.fromPayload(payload),
    );
    return result.when(
      success: (dto) async {
        try {
          final model = dto.model();

          await local.syncCategories(model.collection.models);

          return Success<BaseException, GetCategoryModel>(model);
        } catch (e, stackTrace) {
          talker.handle(e, stackTrace, "Kategoriyani o'qishda xato");

          final localCategories = await local.getAllCategories();

          return Success<BaseException, GetCategoryModel>(
            GetCategoryModel(
              next: "",
              previous: "",
              total: 0,
              collection: CategoryCollection(models: localCategories),
            ),
          );
        }
      },
      failure: (e) async {
        final localCategories = await local.getAllCategories();
        if (localCategories.isNotEmpty) {
          return Success<BaseException, GetCategoryModel>(
            GetCategoryModel(
              next: "",
              previous: "",
              total: 0,
              collection: CategoryCollection(models: localCategories),
            ),
          );
        } else {
          return Failure(e);
        }
      },
    );
  }

  @override
  Future<Safed<BaseException, CategoryModel>> createCategory({
    required CreateCategoryPayload payload,
  }) async {
    return await remote
        .createCategory(request: CreateCategoryRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, CategoryModel>> updateCategory({
    required UpdateCategoryPayload payload,
  }) async {
    return await remote
        .updateCategory(request: UpdateCategoryRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, DeleteCategoryModel>> deleteCategory({
    required DeleteCategoryPayload payload,
  }) async {
    return await remote
        .deleteCategory(request: DeleteCategoryRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }
}
