import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../../../shared/data/sources/local_sources.dart';
import '../../../domain/model/category_model.dart';

class CategoryLocalSource {
  final db = PosLocalDatabase.instance;

  CategoryTableCompanion _toCompanion(CategoryModel model) {
    return CategoryTableCompanion(
      id: Value(model.id),
      title: Value(model.title),
      image: Value(jsonEncode(model.image)),
    );
  }

  Future<void> insertCategory(CategoryModel model) async {
    await db.into(db.categoryTable).insert(
          _toCompanion(model),
          mode: InsertMode.insertOrReplace,
        );
  }

  Future<void> insertCategoriesBatch(List<CategoryModel> categories) async {
    if (categories.isEmpty) return;

    await db.batch((batch) {
      batch.insertAll(
        db.categoryTable,
        categories.map(_toCompanion).toList(),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> syncCategories(List<CategoryModel> categories) async {
    await db.transaction(() async {
      await db.delete(db.categoryTable).go();

      if (categories.isNotEmpty) {
        await db.batch((batch) {
          batch.insertAll(
            db.categoryTable,
            categories.map(_toCompanion).toList(),
            mode: InsertMode.insertOrReplace,
          );
        });
      }
    });
  }

  Future<List<CategoryModel>> getAllCategories() async {
    final rows = await db.select(db.categoryTable).get();

    return rows.map((row) {
      return CategoryModel(
        id: row.id,
        title: row.title,
        image: row.image ?? "",
      );
    }).toList();
  }
}
