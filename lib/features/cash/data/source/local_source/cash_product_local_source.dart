import 'package:baraka_pos/features/cash/domain/model/cash_product_model.dart';
import 'package:baraka_pos/shared/data/sources/local_sources.dart';
import 'package:drift/drift.dart';

class CashProductLocalSource {
  final PosLocalDatabase db;

  CashProductLocalSource(this.db);
  ProductTableCompanion _toCompanion(CashProductModel product) {
    return ProductTableCompanion(
      id: Value(product.id),
      title: Value(product.title),
      cost: Value(product.cost),
      price: Value(product.price),
      wholesalePrice: Value(product.wholesalePrice),
      stock: Value(product.stock),
      categoryTitle: Value(product.categoryTitle),
      unit: Value(product.unit),
      packSize: Value(product.packSize),
      meterPrice: Value(product.meterPrice),
      qrcode: Value(product.qrcode),
      warehouse: Value(product.warehouse),
      images: Value(product.images),
    );
  }

  Future<void> insertProduct(CashProductModel product) async {
    await db.into(db.productTable).insert(
          _toCompanion(product),
          mode: InsertMode.insertOrReplace,
        );
  }

  Future<void> insertProductsBatch(List<CashProductModel> products) async {
    if (products.isEmpty) return;

    await db.batch((batch) {
      batch.insertAll(
        db.productTable,
        products.map(_toCompanion).toList(),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> syncProducts(List<CashProductModel> products) async {
    await db.transaction(() async {
      await db.delete(db.productTable).go();

      if (products.isEmpty) return;

      await db.batch((batch) {
        batch.insertAll(
          db.productTable,
          products.map(_toCompanion).toList(),
          mode: InsertMode.insertOrReplace,
        );
      });
    });
  }

  Future<List<CashProductModel>> getAllProducts({
    String search = '',
    String category = '',
  }) async {
    final query = db.select(db.productTable);

    if (search.isNotEmpty) {
      query.where((tbl) => tbl.title.like('%$search%'));
    }

    if (category.isNotEmpty) {
      query.where((tbl) => tbl.categoryTitle.equals(category));
    }

    final rows = await query.get();

    return rows
        .map(
          (e) => CashProductModel(
            id: e.id,
            title: e.title,
            cost: e.cost,
            price: e.price,
            wholesalePrice: e.wholesalePrice,
            stock: e.stock,
            categoryTitle: e.categoryTitle,
            unit: e.unit,
            qrcode: e.qrcode,
            warehouse: e.warehouse,
            images: e.images,
            packSize: e.packSize!,
            meterPrice: e.meterPrice,
          ),
        )
        .toList();
  }
}
