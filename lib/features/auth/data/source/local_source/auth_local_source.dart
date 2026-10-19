import 'dart:convert';

import 'package:baraka_pos/features/auth/auth.dart';
import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:drift/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../shared/data/sources/local_sources.dart';

class AuthLocalSource {
  final PosLocalDatabase db;

  AuthLocalSource(this.db);

  /// Tokenlar shared_preferences'da ham saqlanadi: webda drift (IndexedDB)
  /// yozuvlarni kechiktirib saqlaydi, sahifa yangilansa yangi refresh token
  /// yo'qolib, eskisi esa backendda blacklist bo'lib qolardi.
  static const _accessKey = 'baraka_pos_access_token';
  static const _refreshKey = 'baraka_pos_refresh_token';

  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessKey, accessToken);
    await prefs.setString(_refreshKey, refreshToken);
  }

  /// Login bo‘lganda chaqiriladi
  /// Backenddan kelgan user ma’lumotini saqlaydi va token qo‘yadi
  Future<void> saveLogin({
    required String accessToken,
    required String refreshToken,
    required Map<String, dynamic> userJson,
  }) async {
    await db.delete(db.authTable).go();

    final warehouse = userJson['warehouse'] ?? {};
    final permissions = userJson['permissions'] ?? {};

    final userCompanion = UserTableCompanion(
      id: Value(userJson.integer('id')),
      name: Value(userJson['name'] ?? ""),
      role: Value(userJson['role'] ?? ""),
      code: Value(userJson['code'] ?? ""),
      phone: Value(userJson['phone'] ?? ""),
      limit:
          Value(userJson['limit'] != null ? userJson['limit'].toString() : ""),
      dateJoined: Value(userJson['date_joined'] ?? ""),
      limitExceeded: Value(userJson['limit_exceeded'] ?? false),
      image: Value(
          userJson['images'] != null ? jsonEncode(userJson['images']) : ""),
      warehouseId: Value(warehouse['id'] ?? 0),
      warehouseUuid: Value(warehouse['uuid'] ?? ""),
      warehouseShopName: Value(warehouse['shop_name'] ?? ""),
      warehouseAddress: Value(warehouse['address'] ?? ""),
      warehouseContact: Value(warehouse['contact'] ?? ""),
      warehousePhrase: Value(warehouse['phrase'] ?? ""),
      warehouseOwner: Value(warehouse['owner'] ?? 0),
      canDiscount: Value(permissions['can_discount'] == true),
      maxDiscountPercent: Value(
          double.tryParse('${permissions['max_discount_percent'] ?? 0}') ?? 0),
      canEditPrice: Value(permissions['can_edit_price'] != false),
      canRefund: Value(permissions['can_refund'] != false),
    );

    await db
        .into(db.userTable)
        .insert(userCompanion, mode: InsertMode.insertOrReplace);

    final authCompanion = AuthTableCompanion(
      accessToken: Value(accessToken),
      refreshToken: Value(refreshToken),
      userId: Value(userJson.integer('id')),
    );

    await db
        .into(db.authTable)
        .insert(authCompanion, mode: InsertMode.insertOrReplace);
    await _saveTokens(accessToken, refreshToken);

    globalUser = await getCurrentUser();
  }

  /// Current logged-in user token va ma’lumotini olish
  Future<AuthTableData?> getCurrentAuth() async {
    final query = await (db.select(db.authTable)
          ..orderBy(
              [(t) => OrderingTerm.desc(t.userId)])) // yoki boshqa id/timestamp
        .getSingleOrNull();
    if (query == null) return null;

    final prefs = await SharedPreferences.getInstance();
    final access = prefs.getString(_accessKey);
    final refresh = prefs.getString(_refreshKey);
    if (access == null || refresh == null) return query;
    return query.copyWith(accessToken: access, refreshToken: refresh);
  }

  Future<void> updateMarketInformation({
    required int warehouseId,
    required String uuid,
    required String shopName,
    required String address,
    required String contact,
    required String phrase,
    required int owner,
  }) async {
    final auth = await getCurrentAuth();
    if (auth == null) return;

    final updateCompanion = UserTableCompanion(
      warehouseId: Value(warehouseId),
      warehouseUuid: Value(uuid),
      warehouseShopName: Value(shopName),
      warehouseAddress: Value(address),
      warehouseContact: Value(contact),
      warehousePhrase: Value(phrase),
      warehouseOwner: Value(owner),
    );

    await (db.update(db.userTable)..where((t) => t.id.equals(auth.userId)))
        .write(updateCompanion);

    // optional: globalUser yangilash
    globalUser = await getCurrentUser();
  }

  /// Current logged-in user ma’lumotini olish
  Future<UserTableData?> getCurrentUser() async {
    final auth = await getCurrentAuth();
    if (auth == null) return null;

    final user = await (db.select(db.userTable)
          ..where((t) => t.id.equals(auth.userId)))
        .getSingleOrNull();
    return user;
  }

  /// Logout – faqat tokenni o‘chirish
  Future<void> logout() async {
    await db.delete(db.authTable).go();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessKey);
    await prefs.remove(_refreshKey);
  }

  /// Token mavjudligini tekshirish
  Future<bool> hasToken() async {
    final auth = await getCurrentAuth();
    return auth != null;
  }

  Future<List<UserTableData>> getAllUsers() async {
    return await db.select(db.userTable).get();
  }

  /// Backenddan kelgan yangi access va refresh tokenlarni yangilash
  /// (`userJson` kelmasa faqat tokenlar yoziladi)
  Future<void> updateTokens({
    required String accessToken,
    required String refreshToken,
    Map<String, dynamic>? userJson,
  }) async {
    final auth = await getCurrentAuth();
    if (auth == null) return;

    // Avval tokenlar — ular eng muhimi
    await _saveTokens(accessToken, refreshToken);
    await (db.update(db.authTable)..where((t) => t.userId.equals(auth.userId)))
        .write(AuthTableCompanion(
      accessToken: Value(accessToken),
      refreshToken: Value(refreshToken),
    ));

    if (userJson == null) return;

    final warehouse = userJson['warehouse'] ?? {};
    final permissions = userJson['permissions'] ?? {};

    /// 🔹 USER TABLE UPDATE
    final userUpdateCompanion = UserTableCompanion(
      id: Value(userJson.integer('id')),
      name: Value(userJson['name'] ?? ""),
      role: Value(userJson['role'] ?? ""),
      code: Value(userJson['code'] ?? ""),
      phone: Value(userJson['phone'] ?? ""),
      limit:
          Value(userJson['limit'] != null ? userJson['limit'].toString() : ""),
      dateJoined: Value(userJson['date_joined'] ?? ""),
      limitExceeded: Value(userJson['limit_exceeded'] ?? false),
      image: Value(
          userJson['images'] != null ? jsonEncode(userJson['images']) : ""),
      warehouseId: Value(warehouse['id'] ?? 0),
      warehouseUuid: Value(warehouse['uuid'] ?? ""),
      warehouseShopName: Value(warehouse['shop_name'] ?? ""),
      warehouseAddress: Value(warehouse['address'] ?? ""),
      warehouseContact: Value(warehouse['contact'] ?? ""),
      warehousePhrase: Value(warehouse['phrase'] ?? ""),
      warehouseOwner: Value(warehouse['owner'] ?? 0),
      canDiscount: Value(permissions['can_discount'] == true),
      maxDiscountPercent: Value(
          double.tryParse('${permissions['max_discount_percent'] ?? 0}') ?? 0),
      canEditPrice: Value(permissions['can_edit_price'] != false),
      canRefund: Value(permissions['can_refund'] != false),
    );

    await (db.update(db.userTable)..where((t) => t.id.equals(auth.userId)))
        .write(userUpdateCompanion);
  }
}
