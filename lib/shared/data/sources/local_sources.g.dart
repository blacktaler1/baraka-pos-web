// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_sources.dart';

// ignore_for_file: type=lint
class $UserTableTable extends UserTable
    with TableInfo<$UserTableTable, UserTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _limitMeta = const VerificationMeta('limit');
  @override
  late final GeneratedColumn<String> limit = GeneratedColumn<String>(
      'limit', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _dateJoinedMeta =
      const VerificationMeta('dateJoined');
  @override
  late final GeneratedColumn<String> dateJoined = GeneratedColumn<String>(
      'date_joined', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _limitExceededMeta =
      const VerificationMeta('limitExceeded');
  @override
  late final GeneratedColumn<bool> limitExceeded = GeneratedColumn<bool>(
      'limit_exceeded', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("limit_exceeded" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _warehouseIdMeta =
      const VerificationMeta('warehouseId');
  @override
  late final GeneratedColumn<int> warehouseId = GeneratedColumn<int>(
      'warehouse_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _warehouseUuidMeta =
      const VerificationMeta('warehouseUuid');
  @override
  late final GeneratedColumn<String> warehouseUuid = GeneratedColumn<String>(
      'warehouse_uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _warehouseShopNameMeta =
      const VerificationMeta('warehouseShopName');
  @override
  late final GeneratedColumn<String> warehouseShopName =
      GeneratedColumn<String>('warehouse_shop_name', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant(''));
  static const VerificationMeta _warehouseAddressMeta =
      const VerificationMeta('warehouseAddress');
  @override
  late final GeneratedColumn<String> warehouseAddress = GeneratedColumn<String>(
      'warehouse_address', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _warehouseContactMeta =
      const VerificationMeta('warehouseContact');
  @override
  late final GeneratedColumn<String> warehouseContact = GeneratedColumn<String>(
      'warehouse_contact', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _warehousePhraseMeta =
      const VerificationMeta('warehousePhrase');
  @override
  late final GeneratedColumn<String> warehousePhrase = GeneratedColumn<String>(
      'warehouse_phrase', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _warehouseOwnerMeta =
      const VerificationMeta('warehouseOwner');
  @override
  late final GeneratedColumn<int> warehouseOwner = GeneratedColumn<int>(
      'warehouse_owner', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _canDiscountMeta =
      const VerificationMeta('canDiscount');
  @override
  late final GeneratedColumn<bool> canDiscount = GeneratedColumn<bool>(
      'can_discount', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("can_discount" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _maxDiscountPercentMeta =
      const VerificationMeta('maxDiscountPercent');
  @override
  late final GeneratedColumn<double> maxDiscountPercent =
      GeneratedColumn<double>('max_discount_percent', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(0));
  static const VerificationMeta _canEditPriceMeta =
      const VerificationMeta('canEditPrice');
  @override
  late final GeneratedColumn<bool> canEditPrice = GeneratedColumn<bool>(
      'can_edit_price', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("can_edit_price" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _canRefundMeta =
      const VerificationMeta('canRefund');
  @override
  late final GeneratedColumn<bool> canRefund = GeneratedColumn<bool>(
      'can_refund', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("can_refund" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        role,
        code,
        phone,
        limit,
        dateJoined,
        limitExceeded,
        image,
        warehouseId,
        warehouseUuid,
        warehouseShopName,
        warehouseAddress,
        warehouseContact,
        warehousePhrase,
        warehouseOwner,
        canDiscount,
        maxDiscountPercent,
        canEditPrice,
        canRefund
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_table';
  @override
  VerificationContext validateIntegrity(Insertable<UserTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('limit')) {
      context.handle(
          _limitMeta, limit.isAcceptableOrUnknown(data['limit']!, _limitMeta));
    }
    if (data.containsKey('date_joined')) {
      context.handle(
          _dateJoinedMeta,
          dateJoined.isAcceptableOrUnknown(
              data['date_joined']!, _dateJoinedMeta));
    }
    if (data.containsKey('limit_exceeded')) {
      context.handle(
          _limitExceededMeta,
          limitExceeded.isAcceptableOrUnknown(
              data['limit_exceeded']!, _limitExceededMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    if (data.containsKey('warehouse_id')) {
      context.handle(
          _warehouseIdMeta,
          warehouseId.isAcceptableOrUnknown(
              data['warehouse_id']!, _warehouseIdMeta));
    }
    if (data.containsKey('warehouse_uuid')) {
      context.handle(
          _warehouseUuidMeta,
          warehouseUuid.isAcceptableOrUnknown(
              data['warehouse_uuid']!, _warehouseUuidMeta));
    }
    if (data.containsKey('warehouse_shop_name')) {
      context.handle(
          _warehouseShopNameMeta,
          warehouseShopName.isAcceptableOrUnknown(
              data['warehouse_shop_name']!, _warehouseShopNameMeta));
    }
    if (data.containsKey('warehouse_address')) {
      context.handle(
          _warehouseAddressMeta,
          warehouseAddress.isAcceptableOrUnknown(
              data['warehouse_address']!, _warehouseAddressMeta));
    }
    if (data.containsKey('warehouse_contact')) {
      context.handle(
          _warehouseContactMeta,
          warehouseContact.isAcceptableOrUnknown(
              data['warehouse_contact']!, _warehouseContactMeta));
    }
    if (data.containsKey('warehouse_phrase')) {
      context.handle(
          _warehousePhraseMeta,
          warehousePhrase.isAcceptableOrUnknown(
              data['warehouse_phrase']!, _warehousePhraseMeta));
    }
    if (data.containsKey('warehouse_owner')) {
      context.handle(
          _warehouseOwnerMeta,
          warehouseOwner.isAcceptableOrUnknown(
              data['warehouse_owner']!, _warehouseOwnerMeta));
    }
    if (data.containsKey('can_discount')) {
      context.handle(
          _canDiscountMeta,
          canDiscount.isAcceptableOrUnknown(
              data['can_discount']!, _canDiscountMeta));
    }
    if (data.containsKey('max_discount_percent')) {
      context.handle(
          _maxDiscountPercentMeta,
          maxDiscountPercent.isAcceptableOrUnknown(
              data['max_discount_percent']!, _maxDiscountPercentMeta));
    }
    if (data.containsKey('can_edit_price')) {
      context.handle(
          _canEditPriceMeta,
          canEditPrice.isAcceptableOrUnknown(
              data['can_edit_price']!, _canEditPriceMeta));
    }
    if (data.containsKey('can_refund')) {
      context.handle(_canRefundMeta,
          canRefund.isAcceptableOrUnknown(data['can_refund']!, _canRefundMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone'])!,
      limit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}limit'])!,
      dateJoined: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date_joined'])!,
      limitExceeded: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}limit_exceeded'])!,
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image'])!,
      warehouseId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}warehouse_id']),
      warehouseUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}warehouse_uuid'])!,
      warehouseShopName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}warehouse_shop_name'])!,
      warehouseAddress: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}warehouse_address'])!,
      warehouseContact: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}warehouse_contact'])!,
      warehousePhrase: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}warehouse_phrase'])!,
      warehouseOwner: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}warehouse_owner'])!,
      canDiscount: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}can_discount'])!,
      maxDiscountPercent: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}max_discount_percent'])!,
      canEditPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}can_edit_price'])!,
      canRefund: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}can_refund'])!,
    );
  }

  @override
  $UserTableTable createAlias(String alias) {
    return $UserTableTable(attachedDatabase, alias);
  }
}

class UserTableData extends DataClass implements Insertable<UserTableData> {
  /// Backend user id
  final int id;
  final String? name;
  final String role;
  final String code;
  final String phone;
  final String limit;
  final String dateJoined;
  final bool limitExceeded;
  final String image;

  /// 🔽 WAREHOUSE
  final int? warehouseId;
  final String warehouseUuid;
  final String warehouseShopName;
  final String warehouseAddress;
  final String warehouseContact;
  final String warehousePhrase;
  final int warehouseOwner;
  final bool canDiscount;
  final double maxDiscountPercent;
  final bool canEditPrice;
  final bool canRefund;
  const UserTableData(
      {required this.id,
      this.name,
      required this.role,
      required this.code,
      required this.phone,
      required this.limit,
      required this.dateJoined,
      required this.limitExceeded,
      required this.image,
      this.warehouseId,
      required this.warehouseUuid,
      required this.warehouseShopName,
      required this.warehouseAddress,
      required this.warehouseContact,
      required this.warehousePhrase,
      required this.warehouseOwner,
      required this.canDiscount,
      required this.maxDiscountPercent,
      required this.canEditPrice,
      required this.canRefund});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['role'] = Variable<String>(role);
    map['code'] = Variable<String>(code);
    map['phone'] = Variable<String>(phone);
    map['limit'] = Variable<String>(limit);
    map['date_joined'] = Variable<String>(dateJoined);
    map['limit_exceeded'] = Variable<bool>(limitExceeded);
    map['image'] = Variable<String>(image);
    if (!nullToAbsent || warehouseId != null) {
      map['warehouse_id'] = Variable<int>(warehouseId);
    }
    map['warehouse_uuid'] = Variable<String>(warehouseUuid);
    map['warehouse_shop_name'] = Variable<String>(warehouseShopName);
    map['warehouse_address'] = Variable<String>(warehouseAddress);
    map['warehouse_contact'] = Variable<String>(warehouseContact);
    map['warehouse_phrase'] = Variable<String>(warehousePhrase);
    map['warehouse_owner'] = Variable<int>(warehouseOwner);
    map['can_discount'] = Variable<bool>(canDiscount);
    map['max_discount_percent'] = Variable<double>(maxDiscountPercent);
    map['can_edit_price'] = Variable<bool>(canEditPrice);
    map['can_refund'] = Variable<bool>(canRefund);
    return map;
  }

  UserTableCompanion toCompanion(bool nullToAbsent) {
    return UserTableCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      role: Value(role),
      code: Value(code),
      phone: Value(phone),
      limit: Value(limit),
      dateJoined: Value(dateJoined),
      limitExceeded: Value(limitExceeded),
      image: Value(image),
      warehouseId: warehouseId == null && nullToAbsent
          ? const Value.absent()
          : Value(warehouseId),
      warehouseUuid: Value(warehouseUuid),
      warehouseShopName: Value(warehouseShopName),
      warehouseAddress: Value(warehouseAddress),
      warehouseContact: Value(warehouseContact),
      warehousePhrase: Value(warehousePhrase),
      warehouseOwner: Value(warehouseOwner),
      canDiscount: Value(canDiscount),
      maxDiscountPercent: Value(maxDiscountPercent),
      canEditPrice: Value(canEditPrice),
      canRefund: Value(canRefund),
    );
  }

  factory UserTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      role: serializer.fromJson<String>(json['role']),
      code: serializer.fromJson<String>(json['code']),
      phone: serializer.fromJson<String>(json['phone']),
      limit: serializer.fromJson<String>(json['limit']),
      dateJoined: serializer.fromJson<String>(json['dateJoined']),
      limitExceeded: serializer.fromJson<bool>(json['limitExceeded']),
      image: serializer.fromJson<String>(json['image']),
      warehouseId: serializer.fromJson<int?>(json['warehouseId']),
      warehouseUuid: serializer.fromJson<String>(json['warehouseUuid']),
      warehouseShopName: serializer.fromJson<String>(json['warehouseShopName']),
      warehouseAddress: serializer.fromJson<String>(json['warehouseAddress']),
      warehouseContact: serializer.fromJson<String>(json['warehouseContact']),
      warehousePhrase: serializer.fromJson<String>(json['warehousePhrase']),
      warehouseOwner: serializer.fromJson<int>(json['warehouseOwner']),
      canDiscount: serializer.fromJson<bool>(json['canDiscount']),
      maxDiscountPercent:
          serializer.fromJson<double>(json['maxDiscountPercent']),
      canEditPrice: serializer.fromJson<bool>(json['canEditPrice']),
      canRefund: serializer.fromJson<bool>(json['canRefund']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'role': serializer.toJson<String>(role),
      'code': serializer.toJson<String>(code),
      'phone': serializer.toJson<String>(phone),
      'limit': serializer.toJson<String>(limit),
      'dateJoined': serializer.toJson<String>(dateJoined),
      'limitExceeded': serializer.toJson<bool>(limitExceeded),
      'image': serializer.toJson<String>(image),
      'warehouseId': serializer.toJson<int?>(warehouseId),
      'warehouseUuid': serializer.toJson<String>(warehouseUuid),
      'warehouseShopName': serializer.toJson<String>(warehouseShopName),
      'warehouseAddress': serializer.toJson<String>(warehouseAddress),
      'warehouseContact': serializer.toJson<String>(warehouseContact),
      'warehousePhrase': serializer.toJson<String>(warehousePhrase),
      'warehouseOwner': serializer.toJson<int>(warehouseOwner),
      'canDiscount': serializer.toJson<bool>(canDiscount),
      'maxDiscountPercent': serializer.toJson<double>(maxDiscountPercent),
      'canEditPrice': serializer.toJson<bool>(canEditPrice),
      'canRefund': serializer.toJson<bool>(canRefund),
    };
  }

  UserTableData copyWith(
          {int? id,
          Value<String?> name = const Value.absent(),
          String? role,
          String? code,
          String? phone,
          String? limit,
          String? dateJoined,
          bool? limitExceeded,
          String? image,
          Value<int?> warehouseId = const Value.absent(),
          String? warehouseUuid,
          String? warehouseShopName,
          String? warehouseAddress,
          String? warehouseContact,
          String? warehousePhrase,
          int? warehouseOwner,
          bool? canDiscount,
          double? maxDiscountPercent,
          bool? canEditPrice,
          bool? canRefund}) =>
      UserTableData(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        role: role ?? this.role,
        code: code ?? this.code,
        phone: phone ?? this.phone,
        limit: limit ?? this.limit,
        dateJoined: dateJoined ?? this.dateJoined,
        limitExceeded: limitExceeded ?? this.limitExceeded,
        image: image ?? this.image,
        warehouseId: warehouseId.present ? warehouseId.value : this.warehouseId,
        warehouseUuid: warehouseUuid ?? this.warehouseUuid,
        warehouseShopName: warehouseShopName ?? this.warehouseShopName,
        warehouseAddress: warehouseAddress ?? this.warehouseAddress,
        warehouseContact: warehouseContact ?? this.warehouseContact,
        warehousePhrase: warehousePhrase ?? this.warehousePhrase,
        warehouseOwner: warehouseOwner ?? this.warehouseOwner,
        canDiscount: canDiscount ?? this.canDiscount,
        maxDiscountPercent: maxDiscountPercent ?? this.maxDiscountPercent,
        canEditPrice: canEditPrice ?? this.canEditPrice,
        canRefund: canRefund ?? this.canRefund,
      );
  UserTableData copyWithCompanion(UserTableCompanion data) {
    return UserTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      role: data.role.present ? data.role.value : this.role,
      code: data.code.present ? data.code.value : this.code,
      phone: data.phone.present ? data.phone.value : this.phone,
      limit: data.limit.present ? data.limit.value : this.limit,
      dateJoined:
          data.dateJoined.present ? data.dateJoined.value : this.dateJoined,
      limitExceeded: data.limitExceeded.present
          ? data.limitExceeded.value
          : this.limitExceeded,
      image: data.image.present ? data.image.value : this.image,
      warehouseId:
          data.warehouseId.present ? data.warehouseId.value : this.warehouseId,
      warehouseUuid: data.warehouseUuid.present
          ? data.warehouseUuid.value
          : this.warehouseUuid,
      warehouseShopName: data.warehouseShopName.present
          ? data.warehouseShopName.value
          : this.warehouseShopName,
      warehouseAddress: data.warehouseAddress.present
          ? data.warehouseAddress.value
          : this.warehouseAddress,
      warehouseContact: data.warehouseContact.present
          ? data.warehouseContact.value
          : this.warehouseContact,
      warehousePhrase: data.warehousePhrase.present
          ? data.warehousePhrase.value
          : this.warehousePhrase,
      warehouseOwner: data.warehouseOwner.present
          ? data.warehouseOwner.value
          : this.warehouseOwner,
      canDiscount:
          data.canDiscount.present ? data.canDiscount.value : this.canDiscount,
      maxDiscountPercent: data.maxDiscountPercent.present
          ? data.maxDiscountPercent.value
          : this.maxDiscountPercent,
      canEditPrice: data.canEditPrice.present
          ? data.canEditPrice.value
          : this.canEditPrice,
      canRefund: data.canRefund.present ? data.canRefund.value : this.canRefund,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('code: $code, ')
          ..write('phone: $phone, ')
          ..write('limit: $limit, ')
          ..write('dateJoined: $dateJoined, ')
          ..write('limitExceeded: $limitExceeded, ')
          ..write('image: $image, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('warehouseUuid: $warehouseUuid, ')
          ..write('warehouseShopName: $warehouseShopName, ')
          ..write('warehouseAddress: $warehouseAddress, ')
          ..write('warehouseContact: $warehouseContact, ')
          ..write('warehousePhrase: $warehousePhrase, ')
          ..write('warehouseOwner: $warehouseOwner, ')
          ..write('canDiscount: $canDiscount, ')
          ..write('maxDiscountPercent: $maxDiscountPercent, ')
          ..write('canEditPrice: $canEditPrice, ')
          ..write('canRefund: $canRefund')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      role,
      code,
      phone,
      limit,
      dateJoined,
      limitExceeded,
      image,
      warehouseId,
      warehouseUuid,
      warehouseShopName,
      warehouseAddress,
      warehouseContact,
      warehousePhrase,
      warehouseOwner,
      canDiscount,
      maxDiscountPercent,
      canEditPrice,
      canRefund);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.role == this.role &&
          other.code == this.code &&
          other.phone == this.phone &&
          other.limit == this.limit &&
          other.dateJoined == this.dateJoined &&
          other.limitExceeded == this.limitExceeded &&
          other.image == this.image &&
          other.warehouseId == this.warehouseId &&
          other.warehouseUuid == this.warehouseUuid &&
          other.warehouseShopName == this.warehouseShopName &&
          other.warehouseAddress == this.warehouseAddress &&
          other.warehouseContact == this.warehouseContact &&
          other.warehousePhrase == this.warehousePhrase &&
          other.warehouseOwner == this.warehouseOwner &&
          other.canDiscount == this.canDiscount &&
          other.maxDiscountPercent == this.maxDiscountPercent &&
          other.canEditPrice == this.canEditPrice &&
          other.canRefund == this.canRefund);
}

class UserTableCompanion extends UpdateCompanion<UserTableData> {
  final Value<int> id;
  final Value<String?> name;
  final Value<String> role;
  final Value<String> code;
  final Value<String> phone;
  final Value<String> limit;
  final Value<String> dateJoined;
  final Value<bool> limitExceeded;
  final Value<String> image;
  final Value<int?> warehouseId;
  final Value<String> warehouseUuid;
  final Value<String> warehouseShopName;
  final Value<String> warehouseAddress;
  final Value<String> warehouseContact;
  final Value<String> warehousePhrase;
  final Value<int> warehouseOwner;
  final Value<bool> canDiscount;
  final Value<double> maxDiscountPercent;
  final Value<bool> canEditPrice;
  final Value<bool> canRefund;
  const UserTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.role = const Value.absent(),
    this.code = const Value.absent(),
    this.phone = const Value.absent(),
    this.limit = const Value.absent(),
    this.dateJoined = const Value.absent(),
    this.limitExceeded = const Value.absent(),
    this.image = const Value.absent(),
    this.warehouseId = const Value.absent(),
    this.warehouseUuid = const Value.absent(),
    this.warehouseShopName = const Value.absent(),
    this.warehouseAddress = const Value.absent(),
    this.warehouseContact = const Value.absent(),
    this.warehousePhrase = const Value.absent(),
    this.warehouseOwner = const Value.absent(),
    this.canDiscount = const Value.absent(),
    this.maxDiscountPercent = const Value.absent(),
    this.canEditPrice = const Value.absent(),
    this.canRefund = const Value.absent(),
  });
  UserTableCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.role = const Value.absent(),
    this.code = const Value.absent(),
    this.phone = const Value.absent(),
    this.limit = const Value.absent(),
    this.dateJoined = const Value.absent(),
    this.limitExceeded = const Value.absent(),
    this.image = const Value.absent(),
    this.warehouseId = const Value.absent(),
    this.warehouseUuid = const Value.absent(),
    this.warehouseShopName = const Value.absent(),
    this.warehouseAddress = const Value.absent(),
    this.warehouseContact = const Value.absent(),
    this.warehousePhrase = const Value.absent(),
    this.warehouseOwner = const Value.absent(),
    this.canDiscount = const Value.absent(),
    this.maxDiscountPercent = const Value.absent(),
    this.canEditPrice = const Value.absent(),
    this.canRefund = const Value.absent(),
  });
  static Insertable<UserTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? role,
    Expression<String>? code,
    Expression<String>? phone,
    Expression<String>? limit,
    Expression<String>? dateJoined,
    Expression<bool>? limitExceeded,
    Expression<String>? image,
    Expression<int>? warehouseId,
    Expression<String>? warehouseUuid,
    Expression<String>? warehouseShopName,
    Expression<String>? warehouseAddress,
    Expression<String>? warehouseContact,
    Expression<String>? warehousePhrase,
    Expression<int>? warehouseOwner,
    Expression<bool>? canDiscount,
    Expression<double>? maxDiscountPercent,
    Expression<bool>? canEditPrice,
    Expression<bool>? canRefund,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (role != null) 'role': role,
      if (code != null) 'code': code,
      if (phone != null) 'phone': phone,
      if (limit != null) 'limit': limit,
      if (dateJoined != null) 'date_joined': dateJoined,
      if (limitExceeded != null) 'limit_exceeded': limitExceeded,
      if (image != null) 'image': image,
      if (warehouseId != null) 'warehouse_id': warehouseId,
      if (warehouseUuid != null) 'warehouse_uuid': warehouseUuid,
      if (warehouseShopName != null) 'warehouse_shop_name': warehouseShopName,
      if (warehouseAddress != null) 'warehouse_address': warehouseAddress,
      if (warehouseContact != null) 'warehouse_contact': warehouseContact,
      if (warehousePhrase != null) 'warehouse_phrase': warehousePhrase,
      if (warehouseOwner != null) 'warehouse_owner': warehouseOwner,
      if (canDiscount != null) 'can_discount': canDiscount,
      if (maxDiscountPercent != null)
        'max_discount_percent': maxDiscountPercent,
      if (canEditPrice != null) 'can_edit_price': canEditPrice,
      if (canRefund != null) 'can_refund': canRefund,
    });
  }

  UserTableCompanion copyWith(
      {Value<int>? id,
      Value<String?>? name,
      Value<String>? role,
      Value<String>? code,
      Value<String>? phone,
      Value<String>? limit,
      Value<String>? dateJoined,
      Value<bool>? limitExceeded,
      Value<String>? image,
      Value<int?>? warehouseId,
      Value<String>? warehouseUuid,
      Value<String>? warehouseShopName,
      Value<String>? warehouseAddress,
      Value<String>? warehouseContact,
      Value<String>? warehousePhrase,
      Value<int>? warehouseOwner,
      Value<bool>? canDiscount,
      Value<double>? maxDiscountPercent,
      Value<bool>? canEditPrice,
      Value<bool>? canRefund}) {
    return UserTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      code: code ?? this.code,
      phone: phone ?? this.phone,
      limit: limit ?? this.limit,
      dateJoined: dateJoined ?? this.dateJoined,
      limitExceeded: limitExceeded ?? this.limitExceeded,
      image: image ?? this.image,
      warehouseId: warehouseId ?? this.warehouseId,
      warehouseUuid: warehouseUuid ?? this.warehouseUuid,
      warehouseShopName: warehouseShopName ?? this.warehouseShopName,
      warehouseAddress: warehouseAddress ?? this.warehouseAddress,
      warehouseContact: warehouseContact ?? this.warehouseContact,
      warehousePhrase: warehousePhrase ?? this.warehousePhrase,
      warehouseOwner: warehouseOwner ?? this.warehouseOwner,
      canDiscount: canDiscount ?? this.canDiscount,
      maxDiscountPercent: maxDiscountPercent ?? this.maxDiscountPercent,
      canEditPrice: canEditPrice ?? this.canEditPrice,
      canRefund: canRefund ?? this.canRefund,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (limit.present) {
      map['limit'] = Variable<String>(limit.value);
    }
    if (dateJoined.present) {
      map['date_joined'] = Variable<String>(dateJoined.value);
    }
    if (limitExceeded.present) {
      map['limit_exceeded'] = Variable<bool>(limitExceeded.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (warehouseId.present) {
      map['warehouse_id'] = Variable<int>(warehouseId.value);
    }
    if (warehouseUuid.present) {
      map['warehouse_uuid'] = Variable<String>(warehouseUuid.value);
    }
    if (warehouseShopName.present) {
      map['warehouse_shop_name'] = Variable<String>(warehouseShopName.value);
    }
    if (warehouseAddress.present) {
      map['warehouse_address'] = Variable<String>(warehouseAddress.value);
    }
    if (warehouseContact.present) {
      map['warehouse_contact'] = Variable<String>(warehouseContact.value);
    }
    if (warehousePhrase.present) {
      map['warehouse_phrase'] = Variable<String>(warehousePhrase.value);
    }
    if (warehouseOwner.present) {
      map['warehouse_owner'] = Variable<int>(warehouseOwner.value);
    }
    if (canDiscount.present) {
      map['can_discount'] = Variable<bool>(canDiscount.value);
    }
    if (maxDiscountPercent.present) {
      map['max_discount_percent'] = Variable<double>(maxDiscountPercent.value);
    }
    if (canEditPrice.present) {
      map['can_edit_price'] = Variable<bool>(canEditPrice.value);
    }
    if (canRefund.present) {
      map['can_refund'] = Variable<bool>(canRefund.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('code: $code, ')
          ..write('phone: $phone, ')
          ..write('limit: $limit, ')
          ..write('dateJoined: $dateJoined, ')
          ..write('limitExceeded: $limitExceeded, ')
          ..write('image: $image, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('warehouseUuid: $warehouseUuid, ')
          ..write('warehouseShopName: $warehouseShopName, ')
          ..write('warehouseAddress: $warehouseAddress, ')
          ..write('warehouseContact: $warehouseContact, ')
          ..write('warehousePhrase: $warehousePhrase, ')
          ..write('warehouseOwner: $warehouseOwner, ')
          ..write('canDiscount: $canDiscount, ')
          ..write('maxDiscountPercent: $maxDiscountPercent, ')
          ..write('canEditPrice: $canEditPrice, ')
          ..write('canRefund: $canRefund')
          ..write(')'))
        .toString();
  }
}

class $AuthTableTable extends AuthTable
    with TableInfo<$AuthTableTable, AuthTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuthTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _accessTokenMeta =
      const VerificationMeta('accessToken');
  @override
  late final GeneratedColumn<String> accessToken = GeneratedColumn<String>(
      'access_token', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _refreshTokenMeta =
      const VerificationMeta('refreshToken');
  @override
  late final GeneratedColumn<String> refreshToken = GeneratedColumn<String>(
      'refresh_token', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES UserTable(id)');
  @override
  List<GeneratedColumn> get $columns => [accessToken, refreshToken, userId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'auth_table';
  @override
  VerificationContext validateIntegrity(Insertable<AuthTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('access_token')) {
      context.handle(
          _accessTokenMeta,
          accessToken.isAcceptableOrUnknown(
              data['access_token']!, _accessTokenMeta));
    } else if (isInserting) {
      context.missing(_accessTokenMeta);
    }
    if (data.containsKey('refresh_token')) {
      context.handle(
          _refreshTokenMeta,
          refreshToken.isAcceptableOrUnknown(
              data['refresh_token']!, _refreshTokenMeta));
    } else if (isInserting) {
      context.missing(_refreshTokenMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  AuthTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuthTableData(
      accessToken: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}access_token'])!,
      refreshToken: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}refresh_token'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
    );
  }

  @override
  $AuthTableTable createAlias(String alias) {
    return $AuthTableTable(attachedDatabase, alias);
  }
}

class AuthTableData extends DataClass implements Insertable<AuthTableData> {
  final String accessToken;
  final String refreshToken;
  final int userId;
  const AuthTableData(
      {required this.accessToken,
      required this.refreshToken,
      required this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['access_token'] = Variable<String>(accessToken);
    map['refresh_token'] = Variable<String>(refreshToken);
    map['user_id'] = Variable<int>(userId);
    return map;
  }

  AuthTableCompanion toCompanion(bool nullToAbsent) {
    return AuthTableCompanion(
      accessToken: Value(accessToken),
      refreshToken: Value(refreshToken),
      userId: Value(userId),
    );
  }

  factory AuthTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuthTableData(
      accessToken: serializer.fromJson<String>(json['accessToken']),
      refreshToken: serializer.fromJson<String>(json['refreshToken']),
      userId: serializer.fromJson<int>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accessToken': serializer.toJson<String>(accessToken),
      'refreshToken': serializer.toJson<String>(refreshToken),
      'userId': serializer.toJson<int>(userId),
    };
  }

  AuthTableData copyWith(
          {String? accessToken, String? refreshToken, int? userId}) =>
      AuthTableData(
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
        userId: userId ?? this.userId,
      );
  AuthTableData copyWithCompanion(AuthTableCompanion data) {
    return AuthTableData(
      accessToken:
          data.accessToken.present ? data.accessToken.value : this.accessToken,
      refreshToken: data.refreshToken.present
          ? data.refreshToken.value
          : this.refreshToken,
      userId: data.userId.present ? data.userId.value : this.userId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuthTableData(')
          ..write('accessToken: $accessToken, ')
          ..write('refreshToken: $refreshToken, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(accessToken, refreshToken, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuthTableData &&
          other.accessToken == this.accessToken &&
          other.refreshToken == this.refreshToken &&
          other.userId == this.userId);
}

class AuthTableCompanion extends UpdateCompanion<AuthTableData> {
  final Value<String> accessToken;
  final Value<String> refreshToken;
  final Value<int> userId;
  final Value<int> rowid;
  const AuthTableCompanion({
    this.accessToken = const Value.absent(),
    this.refreshToken = const Value.absent(),
    this.userId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuthTableCompanion.insert({
    required String accessToken,
    required String refreshToken,
    required int userId,
    this.rowid = const Value.absent(),
  })  : accessToken = Value(accessToken),
        refreshToken = Value(refreshToken),
        userId = Value(userId);
  static Insertable<AuthTableData> custom({
    Expression<String>? accessToken,
    Expression<String>? refreshToken,
    Expression<int>? userId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accessToken != null) 'access_token': accessToken,
      if (refreshToken != null) 'refresh_token': refreshToken,
      if (userId != null) 'user_id': userId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuthTableCompanion copyWith(
      {Value<String>? accessToken,
      Value<String>? refreshToken,
      Value<int>? userId,
      Value<int>? rowid}) {
    return AuthTableCompanion(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      userId: userId ?? this.userId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accessToken.present) {
      map['access_token'] = Variable<String>(accessToken.value);
    }
    if (refreshToken.present) {
      map['refresh_token'] = Variable<String>(refreshToken.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuthTableCompanion(')
          ..write('accessToken: $accessToken, ')
          ..write('refreshToken: $refreshToken, ')
          ..write('userId: $userId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductTableTable extends ProductTable
    with TableInfo<$ProductTableTable, ProductTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<String> cost = GeneratedColumn<String>(
      'cost', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<String> price = GeneratedColumn<String>(
      'price', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _wholesalePriceMeta =
      const VerificationMeta('wholesalePrice');
  @override
  late final GeneratedColumn<String> wholesalePrice = GeneratedColumn<String>(
      'wholesale_price', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _stockMeta = const VerificationMeta('stock');
  @override
  late final GeneratedColumn<String> stock = GeneratedColumn<String>(
      'stock', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryTitleMeta =
      const VerificationMeta('categoryTitle');
  @override
  late final GeneratedColumn<String> categoryTitle = GeneratedColumn<String>(
      'category_title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _packSizeMeta =
      const VerificationMeta('packSize');
  @override
  late final GeneratedColumn<int> packSize = GeneratedColumn<int>(
      'pack_size', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _meterPriceMeta =
      const VerificationMeta('meterPrice');
  @override
  late final GeneratedColumn<String> meterPrice = GeneratedColumn<String>(
      'meter_price', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _qrcodeMeta = const VerificationMeta('qrcode');
  @override
  late final GeneratedColumn<String> qrcode = GeneratedColumn<String>(
      'qrcode', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _warehouseMeta =
      const VerificationMeta('warehouse');
  @override
  late final GeneratedColumn<int> warehouse = GeneratedColumn<int>(
      'warehouse', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _imagesMeta = const VerificationMeta('images');
  @override
  late final GeneratedColumn<String> images = GeneratedColumn<String>(
      'images', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        cost,
        price,
        wholesalePrice,
        stock,
        categoryTitle,
        unit,
        packSize,
        meterPrice,
        qrcode,
        warehouse,
        images
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_table';
  @override
  VerificationContext validateIntegrity(Insertable<ProductTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
          _costMeta, cost.isAcceptableOrUnknown(data['cost']!, _costMeta));
    } else if (isInserting) {
      context.missing(_costMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('wholesale_price')) {
      context.handle(
          _wholesalePriceMeta,
          wholesalePrice.isAcceptableOrUnknown(
              data['wholesale_price']!, _wholesalePriceMeta));
    }
    if (data.containsKey('stock')) {
      context.handle(
          _stockMeta, stock.isAcceptableOrUnknown(data['stock']!, _stockMeta));
    } else if (isInserting) {
      context.missing(_stockMeta);
    }
    if (data.containsKey('category_title')) {
      context.handle(
          _categoryTitleMeta,
          categoryTitle.isAcceptableOrUnknown(
              data['category_title']!, _categoryTitleMeta));
    } else if (isInserting) {
      context.missing(_categoryTitleMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('pack_size')) {
      context.handle(_packSizeMeta,
          packSize.isAcceptableOrUnknown(data['pack_size']!, _packSizeMeta));
    }
    if (data.containsKey('meter_price')) {
      context.handle(
          _meterPriceMeta,
          meterPrice.isAcceptableOrUnknown(
              data['meter_price']!, _meterPriceMeta));
    }
    if (data.containsKey('qrcode')) {
      context.handle(_qrcodeMeta,
          qrcode.isAcceptableOrUnknown(data['qrcode']!, _qrcodeMeta));
    } else if (isInserting) {
      context.missing(_qrcodeMeta);
    }
    if (data.containsKey('warehouse')) {
      context.handle(_warehouseMeta,
          warehouse.isAcceptableOrUnknown(data['warehouse']!, _warehouseMeta));
    } else if (isInserting) {
      context.missing(_warehouseMeta);
    }
    if (data.containsKey('images')) {
      context.handle(_imagesMeta,
          images.isAcceptableOrUnknown(data['images']!, _imagesMeta));
    } else if (isInserting) {
      context.missing(_imagesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      cost: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cost'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}price'])!,
      wholesalePrice: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}wholesale_price'])!,
      stock: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stock'])!,
      categoryTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_title'])!,
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit'])!,
      packSize: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pack_size']),
      meterPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}meter_price'])!,
      qrcode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}qrcode'])!,
      warehouse: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}warehouse'])!,
      images: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}images'])!,
    );
  }

  @override
  $ProductTableTable createAlias(String alias) {
    return $ProductTableTable(attachedDatabase, alias);
  }
}

class ProductTableData extends DataClass
    implements Insertable<ProductTableData> {
  final int id;
  final String title;
  final String cost;
  final String price;
  final String wholesalePrice;
  final String stock;
  final String categoryTitle;
  final String unit;
  final int? packSize;
  final String meterPrice;
  final String qrcode;
  final int warehouse;
  final String images;
  const ProductTableData(
      {required this.id,
      required this.title,
      required this.cost,
      required this.price,
      required this.wholesalePrice,
      required this.stock,
      required this.categoryTitle,
      required this.unit,
      this.packSize,
      required this.meterPrice,
      required this.qrcode,
      required this.warehouse,
      required this.images});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['cost'] = Variable<String>(cost);
    map['price'] = Variable<String>(price);
    map['wholesale_price'] = Variable<String>(wholesalePrice);
    map['stock'] = Variable<String>(stock);
    map['category_title'] = Variable<String>(categoryTitle);
    map['unit'] = Variable<String>(unit);
    if (!nullToAbsent || packSize != null) {
      map['pack_size'] = Variable<int>(packSize);
    }
    map['meter_price'] = Variable<String>(meterPrice);
    map['qrcode'] = Variable<String>(qrcode);
    map['warehouse'] = Variable<int>(warehouse);
    map['images'] = Variable<String>(images);
    return map;
  }

  ProductTableCompanion toCompanion(bool nullToAbsent) {
    return ProductTableCompanion(
      id: Value(id),
      title: Value(title),
      cost: Value(cost),
      price: Value(price),
      wholesalePrice: Value(wholesalePrice),
      stock: Value(stock),
      categoryTitle: Value(categoryTitle),
      unit: Value(unit),
      packSize: packSize == null && nullToAbsent
          ? const Value.absent()
          : Value(packSize),
      meterPrice: Value(meterPrice),
      qrcode: Value(qrcode),
      warehouse: Value(warehouse),
      images: Value(images),
    );
  }

  factory ProductTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      cost: serializer.fromJson<String>(json['cost']),
      price: serializer.fromJson<String>(json['price']),
      wholesalePrice: serializer.fromJson<String>(json['wholesalePrice']),
      stock: serializer.fromJson<String>(json['stock']),
      categoryTitle: serializer.fromJson<String>(json['categoryTitle']),
      unit: serializer.fromJson<String>(json['unit']),
      packSize: serializer.fromJson<int?>(json['packSize']),
      meterPrice: serializer.fromJson<String>(json['meterPrice']),
      qrcode: serializer.fromJson<String>(json['qrcode']),
      warehouse: serializer.fromJson<int>(json['warehouse']),
      images: serializer.fromJson<String>(json['images']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'cost': serializer.toJson<String>(cost),
      'price': serializer.toJson<String>(price),
      'wholesalePrice': serializer.toJson<String>(wholesalePrice),
      'stock': serializer.toJson<String>(stock),
      'categoryTitle': serializer.toJson<String>(categoryTitle),
      'unit': serializer.toJson<String>(unit),
      'packSize': serializer.toJson<int?>(packSize),
      'meterPrice': serializer.toJson<String>(meterPrice),
      'qrcode': serializer.toJson<String>(qrcode),
      'warehouse': serializer.toJson<int>(warehouse),
      'images': serializer.toJson<String>(images),
    };
  }

  ProductTableData copyWith(
          {int? id,
          String? title,
          String? cost,
          String? price,
          String? wholesalePrice,
          String? stock,
          String? categoryTitle,
          String? unit,
          Value<int?> packSize = const Value.absent(),
          String? meterPrice,
          String? qrcode,
          int? warehouse,
          String? images}) =>
      ProductTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        cost: cost ?? this.cost,
        price: price ?? this.price,
        wholesalePrice: wholesalePrice ?? this.wholesalePrice,
        stock: stock ?? this.stock,
        categoryTitle: categoryTitle ?? this.categoryTitle,
        unit: unit ?? this.unit,
        packSize: packSize.present ? packSize.value : this.packSize,
        meterPrice: meterPrice ?? this.meterPrice,
        qrcode: qrcode ?? this.qrcode,
        warehouse: warehouse ?? this.warehouse,
        images: images ?? this.images,
      );
  ProductTableData copyWithCompanion(ProductTableCompanion data) {
    return ProductTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      cost: data.cost.present ? data.cost.value : this.cost,
      price: data.price.present ? data.price.value : this.price,
      wholesalePrice: data.wholesalePrice.present
          ? data.wholesalePrice.value
          : this.wholesalePrice,
      stock: data.stock.present ? data.stock.value : this.stock,
      categoryTitle: data.categoryTitle.present
          ? data.categoryTitle.value
          : this.categoryTitle,
      unit: data.unit.present ? data.unit.value : this.unit,
      packSize: data.packSize.present ? data.packSize.value : this.packSize,
      meterPrice:
          data.meterPrice.present ? data.meterPrice.value : this.meterPrice,
      qrcode: data.qrcode.present ? data.qrcode.value : this.qrcode,
      warehouse: data.warehouse.present ? data.warehouse.value : this.warehouse,
      images: data.images.present ? data.images.value : this.images,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('cost: $cost, ')
          ..write('price: $price, ')
          ..write('wholesalePrice: $wholesalePrice, ')
          ..write('stock: $stock, ')
          ..write('categoryTitle: $categoryTitle, ')
          ..write('unit: $unit, ')
          ..write('packSize: $packSize, ')
          ..write('meterPrice: $meterPrice, ')
          ..write('qrcode: $qrcode, ')
          ..write('warehouse: $warehouse, ')
          ..write('images: $images')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, cost, price, wholesalePrice, stock,
      categoryTitle, unit, packSize, meterPrice, qrcode, warehouse, images);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.cost == this.cost &&
          other.price == this.price &&
          other.wholesalePrice == this.wholesalePrice &&
          other.stock == this.stock &&
          other.categoryTitle == this.categoryTitle &&
          other.unit == this.unit &&
          other.packSize == this.packSize &&
          other.meterPrice == this.meterPrice &&
          other.qrcode == this.qrcode &&
          other.warehouse == this.warehouse &&
          other.images == this.images);
}

class ProductTableCompanion extends UpdateCompanion<ProductTableData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> cost;
  final Value<String> price;
  final Value<String> wholesalePrice;
  final Value<String> stock;
  final Value<String> categoryTitle;
  final Value<String> unit;
  final Value<int?> packSize;
  final Value<String> meterPrice;
  final Value<String> qrcode;
  final Value<int> warehouse;
  final Value<String> images;
  const ProductTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.cost = const Value.absent(),
    this.price = const Value.absent(),
    this.wholesalePrice = const Value.absent(),
    this.stock = const Value.absent(),
    this.categoryTitle = const Value.absent(),
    this.unit = const Value.absent(),
    this.packSize = const Value.absent(),
    this.meterPrice = const Value.absent(),
    this.qrcode = const Value.absent(),
    this.warehouse = const Value.absent(),
    this.images = const Value.absent(),
  });
  ProductTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String cost,
    required String price,
    this.wholesalePrice = const Value.absent(),
    required String stock,
    required String categoryTitle,
    required String unit,
    this.packSize = const Value.absent(),
    this.meterPrice = const Value.absent(),
    required String qrcode,
    required int warehouse,
    required String images,
  })  : title = Value(title),
        cost = Value(cost),
        price = Value(price),
        stock = Value(stock),
        categoryTitle = Value(categoryTitle),
        unit = Value(unit),
        qrcode = Value(qrcode),
        warehouse = Value(warehouse),
        images = Value(images);
  static Insertable<ProductTableData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? cost,
    Expression<String>? price,
    Expression<String>? wholesalePrice,
    Expression<String>? stock,
    Expression<String>? categoryTitle,
    Expression<String>? unit,
    Expression<int>? packSize,
    Expression<String>? meterPrice,
    Expression<String>? qrcode,
    Expression<int>? warehouse,
    Expression<String>? images,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (cost != null) 'cost': cost,
      if (price != null) 'price': price,
      if (wholesalePrice != null) 'wholesale_price': wholesalePrice,
      if (stock != null) 'stock': stock,
      if (categoryTitle != null) 'category_title': categoryTitle,
      if (unit != null) 'unit': unit,
      if (packSize != null) 'pack_size': packSize,
      if (meterPrice != null) 'meter_price': meterPrice,
      if (qrcode != null) 'qrcode': qrcode,
      if (warehouse != null) 'warehouse': warehouse,
      if (images != null) 'images': images,
    });
  }

  ProductTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? cost,
      Value<String>? price,
      Value<String>? wholesalePrice,
      Value<String>? stock,
      Value<String>? categoryTitle,
      Value<String>? unit,
      Value<int?>? packSize,
      Value<String>? meterPrice,
      Value<String>? qrcode,
      Value<int>? warehouse,
      Value<String>? images}) {
    return ProductTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      cost: cost ?? this.cost,
      price: price ?? this.price,
      wholesalePrice: wholesalePrice ?? this.wholesalePrice,
      stock: stock ?? this.stock,
      categoryTitle: categoryTitle ?? this.categoryTitle,
      unit: unit ?? this.unit,
      packSize: packSize ?? this.packSize,
      meterPrice: meterPrice ?? this.meterPrice,
      qrcode: qrcode ?? this.qrcode,
      warehouse: warehouse ?? this.warehouse,
      images: images ?? this.images,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (cost.present) {
      map['cost'] = Variable<String>(cost.value);
    }
    if (price.present) {
      map['price'] = Variable<String>(price.value);
    }
    if (wholesalePrice.present) {
      map['wholesale_price'] = Variable<String>(wholesalePrice.value);
    }
    if (stock.present) {
      map['stock'] = Variable<String>(stock.value);
    }
    if (categoryTitle.present) {
      map['category_title'] = Variable<String>(categoryTitle.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (packSize.present) {
      map['pack_size'] = Variable<int>(packSize.value);
    }
    if (meterPrice.present) {
      map['meter_price'] = Variable<String>(meterPrice.value);
    }
    if (qrcode.present) {
      map['qrcode'] = Variable<String>(qrcode.value);
    }
    if (warehouse.present) {
      map['warehouse'] = Variable<int>(warehouse.value);
    }
    if (images.present) {
      map['images'] = Variable<String>(images.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('cost: $cost, ')
          ..write('price: $price, ')
          ..write('wholesalePrice: $wholesalePrice, ')
          ..write('stock: $stock, ')
          ..write('categoryTitle: $categoryTitle, ')
          ..write('unit: $unit, ')
          ..write('packSize: $packSize, ')
          ..write('meterPrice: $meterPrice, ')
          ..write('qrcode: $qrcode, ')
          ..write('warehouse: $warehouse, ')
          ..write('images: $images')
          ..write(')'))
        .toString();
  }
}

class $CategoryTableTable extends CategoryTable
    with TableInfo<$CategoryTableTable, CategoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, image];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_table';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image'])!,
    );
  }

  @override
  $CategoryTableTable createAlias(String alias) {
    return $CategoryTableTable(attachedDatabase, alias);
  }
}

class CategoryTableData extends DataClass
    implements Insertable<CategoryTableData> {
  final int id;
  final String title;
  final String image;
  const CategoryTableData(
      {required this.id, required this.title, required this.image});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['image'] = Variable<String>(image);
    return map;
  }

  CategoryTableCompanion toCompanion(bool nullToAbsent) {
    return CategoryTableCompanion(
      id: Value(id),
      title: Value(title),
      image: Value(image),
    );
  }

  factory CategoryTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      image: serializer.fromJson<String>(json['image']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'image': serializer.toJson<String>(image),
    };
  }

  CategoryTableData copyWith({int? id, String? title, String? image}) =>
      CategoryTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        image: image ?? this.image,
      );
  CategoryTableData copyWithCompanion(CategoryTableCompanion data) {
    return CategoryTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      image: data.image.present ? data.image.value : this.image,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, image);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.image == this.image);
}

class CategoryTableCompanion extends UpdateCompanion<CategoryTableData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> image;
  const CategoryTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.image = const Value.absent(),
  });
  CategoryTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String image,
  })  : title = Value(title),
        image = Value(image);
  static Insertable<CategoryTableData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? image,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (image != null) 'image': image,
    });
  }

  CategoryTableCompanion copyWith(
      {Value<int>? id, Value<String>? title, Value<String>? image}) {
    return CategoryTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }
}

class $PendingTransactionsTable extends PendingTransactions
    with TableInfo<$PendingTransactionsTable, PendingTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, payload, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_transactions';
  @override
  VerificationContext validateIntegrity(Insertable<PendingTransaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PendingTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingTransaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $PendingTransactionsTable createAlias(String alias) {
    return $PendingTransactionsTable(attachedDatabase, alias);
  }
}

class PendingTransaction extends DataClass
    implements Insertable<PendingTransaction> {
  final int id;
  final String payload;
  final DateTime createdAt;
  const PendingTransaction(
      {required this.id, required this.payload, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['payload'] = Variable<String>(payload);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PendingTransactionsCompanion toCompanion(bool nullToAbsent) {
    return PendingTransactionsCompanion(
      id: Value(id),
      payload: Value(payload),
      createdAt: Value(createdAt),
    );
  }

  factory PendingTransaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingTransaction(
      id: serializer.fromJson<int>(json['id']),
      payload: serializer.fromJson<String>(json['payload']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'payload': serializer.toJson<String>(payload),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PendingTransaction copyWith(
          {int? id, String? payload, DateTime? createdAt}) =>
      PendingTransaction(
        id: id ?? this.id,
        payload: payload ?? this.payload,
        createdAt: createdAt ?? this.createdAt,
      );
  PendingTransaction copyWithCompanion(PendingTransactionsCompanion data) {
    return PendingTransaction(
      id: data.id.present ? data.id.value : this.id,
      payload: data.payload.present ? data.payload.value : this.payload,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingTransaction(')
          ..write('id: $id, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, payload, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingTransaction &&
          other.id == this.id &&
          other.payload == this.payload &&
          other.createdAt == this.createdAt);
}

class PendingTransactionsCompanion extends UpdateCompanion<PendingTransaction> {
  final Value<int> id;
  final Value<String> payload;
  final Value<DateTime> createdAt;
  const PendingTransactionsCompanion({
    this.id = const Value.absent(),
    this.payload = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PendingTransactionsCompanion.insert({
    this.id = const Value.absent(),
    required String payload,
    this.createdAt = const Value.absent(),
  }) : payload = Value(payload);
  static Insertable<PendingTransaction> custom({
    Expression<int>? id,
    Expression<String>? payload,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (payload != null) 'payload': payload,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PendingTransactionsCompanion copyWith(
      {Value<int>? id, Value<String>? payload, Value<DateTime>? createdAt}) {
    return PendingTransactionsCompanion(
      id: id ?? this.id,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PrinterSettingsTableTable extends PrinterSettingsTable
    with TableInfo<$PrinterSettingsTableTable, PrinterSettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrinterSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _printerNameMeta =
      const VerificationMeta('printerName');
  @override
  late final GeneratedColumn<String> printerName = GeneratedColumn<String>(
      'printer_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _barcodePrinterNameMeta =
      const VerificationMeta('barcodePrinterName');
  @override
  late final GeneratedColumn<String> barcodePrinterName =
      GeneratedColumn<String>('barcode_printer_name', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, printerName, barcodePrinterName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'printer_settings_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<PrinterSettingsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('printer_name')) {
      context.handle(
          _printerNameMeta,
          printerName.isAcceptableOrUnknown(
              data['printer_name']!, _printerNameMeta));
    }
    if (data.containsKey('barcode_printer_name')) {
      context.handle(
          _barcodePrinterNameMeta,
          barcodePrinterName.isAcceptableOrUnknown(
              data['barcode_printer_name']!, _barcodePrinterNameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PrinterSettingsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrinterSettingsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      printerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}printer_name']),
      barcodePrinterName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}barcode_printer_name']),
    );
  }

  @override
  $PrinterSettingsTableTable createAlias(String alias) {
    return $PrinterSettingsTableTable(attachedDatabase, alias);
  }
}

class PrinterSettingsTableData extends DataClass
    implements Insertable<PrinterSettingsTableData> {
  final int id;
  final String? printerName;
  final String? barcodePrinterName;
  const PrinterSettingsTableData(
      {required this.id, this.printerName, this.barcodePrinterName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || printerName != null) {
      map['printer_name'] = Variable<String>(printerName);
    }
    if (!nullToAbsent || barcodePrinterName != null) {
      map['barcode_printer_name'] = Variable<String>(barcodePrinterName);
    }
    return map;
  }

  PrinterSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return PrinterSettingsTableCompanion(
      id: Value(id),
      printerName: printerName == null && nullToAbsent
          ? const Value.absent()
          : Value(printerName),
      barcodePrinterName: barcodePrinterName == null && nullToAbsent
          ? const Value.absent()
          : Value(barcodePrinterName),
    );
  }

  factory PrinterSettingsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrinterSettingsTableData(
      id: serializer.fromJson<int>(json['id']),
      printerName: serializer.fromJson<String?>(json['printerName']),
      barcodePrinterName:
          serializer.fromJson<String?>(json['barcodePrinterName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'printerName': serializer.toJson<String?>(printerName),
      'barcodePrinterName': serializer.toJson<String?>(barcodePrinterName),
    };
  }

  PrinterSettingsTableData copyWith(
          {int? id,
          Value<String?> printerName = const Value.absent(),
          Value<String?> barcodePrinterName = const Value.absent()}) =>
      PrinterSettingsTableData(
        id: id ?? this.id,
        printerName: printerName.present ? printerName.value : this.printerName,
        barcodePrinterName: barcodePrinterName.present
            ? barcodePrinterName.value
            : this.barcodePrinterName,
      );
  PrinterSettingsTableData copyWithCompanion(
      PrinterSettingsTableCompanion data) {
    return PrinterSettingsTableData(
      id: data.id.present ? data.id.value : this.id,
      printerName:
          data.printerName.present ? data.printerName.value : this.printerName,
      barcodePrinterName: data.barcodePrinterName.present
          ? data.barcodePrinterName.value
          : this.barcodePrinterName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrinterSettingsTableData(')
          ..write('id: $id, ')
          ..write('printerName: $printerName, ')
          ..write('barcodePrinterName: $barcodePrinterName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, printerName, barcodePrinterName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrinterSettingsTableData &&
          other.id == this.id &&
          other.printerName == this.printerName &&
          other.barcodePrinterName == this.barcodePrinterName);
}

class PrinterSettingsTableCompanion
    extends UpdateCompanion<PrinterSettingsTableData> {
  final Value<int> id;
  final Value<String?> printerName;
  final Value<String?> barcodePrinterName;
  const PrinterSettingsTableCompanion({
    this.id = const Value.absent(),
    this.printerName = const Value.absent(),
    this.barcodePrinterName = const Value.absent(),
  });
  PrinterSettingsTableCompanion.insert({
    this.id = const Value.absent(),
    this.printerName = const Value.absent(),
    this.barcodePrinterName = const Value.absent(),
  });
  static Insertable<PrinterSettingsTableData> custom({
    Expression<int>? id,
    Expression<String>? printerName,
    Expression<String>? barcodePrinterName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (printerName != null) 'printer_name': printerName,
      if (barcodePrinterName != null)
        'barcode_printer_name': barcodePrinterName,
    });
  }

  PrinterSettingsTableCompanion copyWith(
      {Value<int>? id,
      Value<String?>? printerName,
      Value<String?>? barcodePrinterName}) {
    return PrinterSettingsTableCompanion(
      id: id ?? this.id,
      printerName: printerName ?? this.printerName,
      barcodePrinterName: barcodePrinterName ?? this.barcodePrinterName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (printerName.present) {
      map['printer_name'] = Variable<String>(printerName.value);
    }
    if (barcodePrinterName.present) {
      map['barcode_printer_name'] = Variable<String>(barcodePrinterName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrinterSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('printerName: $printerName, ')
          ..write('barcodePrinterName: $barcodePrinterName')
          ..write(')'))
        .toString();
  }
}

abstract class _$PosLocalDatabase extends GeneratedDatabase {
  _$PosLocalDatabase(QueryExecutor e) : super(e);
  $PosLocalDatabaseManager get managers => $PosLocalDatabaseManager(this);
  late final $UserTableTable userTable = $UserTableTable(this);
  late final $AuthTableTable authTable = $AuthTableTable(this);
  late final $ProductTableTable productTable = $ProductTableTable(this);
  late final $CategoryTableTable categoryTable = $CategoryTableTable(this);
  late final $PendingTransactionsTable pendingTransactions =
      $PendingTransactionsTable(this);
  late final $PrinterSettingsTableTable printerSettingsTable =
      $PrinterSettingsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        userTable,
        authTable,
        productTable,
        categoryTable,
        pendingTransactions,
        printerSettingsTable
      ];
}

typedef $$UserTableTableCreateCompanionBuilder = UserTableCompanion Function({
  Value<int> id,
  Value<String?> name,
  Value<String> role,
  Value<String> code,
  Value<String> phone,
  Value<String> limit,
  Value<String> dateJoined,
  Value<bool> limitExceeded,
  Value<String> image,
  Value<int?> warehouseId,
  Value<String> warehouseUuid,
  Value<String> warehouseShopName,
  Value<String> warehouseAddress,
  Value<String> warehouseContact,
  Value<String> warehousePhrase,
  Value<int> warehouseOwner,
  Value<bool> canDiscount,
  Value<double> maxDiscountPercent,
  Value<bool> canEditPrice,
  Value<bool> canRefund,
});
typedef $$UserTableTableUpdateCompanionBuilder = UserTableCompanion Function({
  Value<int> id,
  Value<String?> name,
  Value<String> role,
  Value<String> code,
  Value<String> phone,
  Value<String> limit,
  Value<String> dateJoined,
  Value<bool> limitExceeded,
  Value<String> image,
  Value<int?> warehouseId,
  Value<String> warehouseUuid,
  Value<String> warehouseShopName,
  Value<String> warehouseAddress,
  Value<String> warehouseContact,
  Value<String> warehousePhrase,
  Value<int> warehouseOwner,
  Value<bool> canDiscount,
  Value<double> maxDiscountPercent,
  Value<bool> canEditPrice,
  Value<bool> canRefund,
});

class $$UserTableTableFilterComposer
    extends Composer<_$PosLocalDatabase, $UserTableTable> {
  $$UserTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get limit => $composableBuilder(
      column: $table.limit, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dateJoined => $composableBuilder(
      column: $table.dateJoined, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get limitExceeded => $composableBuilder(
      column: $table.limitExceeded, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get warehouseId => $composableBuilder(
      column: $table.warehouseId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get warehouseUuid => $composableBuilder(
      column: $table.warehouseUuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get warehouseShopName => $composableBuilder(
      column: $table.warehouseShopName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get warehouseAddress => $composableBuilder(
      column: $table.warehouseAddress,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get warehouseContact => $composableBuilder(
      column: $table.warehouseContact,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get warehousePhrase => $composableBuilder(
      column: $table.warehousePhrase,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get warehouseOwner => $composableBuilder(
      column: $table.warehouseOwner,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get canDiscount => $composableBuilder(
      column: $table.canDiscount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get maxDiscountPercent => $composableBuilder(
      column: $table.maxDiscountPercent,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get canEditPrice => $composableBuilder(
      column: $table.canEditPrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get canRefund => $composableBuilder(
      column: $table.canRefund, builder: (column) => ColumnFilters(column));
}

class $$UserTableTableOrderingComposer
    extends Composer<_$PosLocalDatabase, $UserTableTable> {
  $$UserTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get limit => $composableBuilder(
      column: $table.limit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dateJoined => $composableBuilder(
      column: $table.dateJoined, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get limitExceeded => $composableBuilder(
      column: $table.limitExceeded,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get warehouseId => $composableBuilder(
      column: $table.warehouseId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get warehouseUuid => $composableBuilder(
      column: $table.warehouseUuid,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get warehouseShopName => $composableBuilder(
      column: $table.warehouseShopName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get warehouseAddress => $composableBuilder(
      column: $table.warehouseAddress,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get warehouseContact => $composableBuilder(
      column: $table.warehouseContact,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get warehousePhrase => $composableBuilder(
      column: $table.warehousePhrase,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get warehouseOwner => $composableBuilder(
      column: $table.warehouseOwner,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get canDiscount => $composableBuilder(
      column: $table.canDiscount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get maxDiscountPercent => $composableBuilder(
      column: $table.maxDiscountPercent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get canEditPrice => $composableBuilder(
      column: $table.canEditPrice,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get canRefund => $composableBuilder(
      column: $table.canRefund, builder: (column) => ColumnOrderings(column));
}

class $$UserTableTableAnnotationComposer
    extends Composer<_$PosLocalDatabase, $UserTableTable> {
  $$UserTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get limit =>
      $composableBuilder(column: $table.limit, builder: (column) => column);

  GeneratedColumn<String> get dateJoined => $composableBuilder(
      column: $table.dateJoined, builder: (column) => column);

  GeneratedColumn<bool> get limitExceeded => $composableBuilder(
      column: $table.limitExceeded, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<int> get warehouseId => $composableBuilder(
      column: $table.warehouseId, builder: (column) => column);

  GeneratedColumn<String> get warehouseUuid => $composableBuilder(
      column: $table.warehouseUuid, builder: (column) => column);

  GeneratedColumn<String> get warehouseShopName => $composableBuilder(
      column: $table.warehouseShopName, builder: (column) => column);

  GeneratedColumn<String> get warehouseAddress => $composableBuilder(
      column: $table.warehouseAddress, builder: (column) => column);

  GeneratedColumn<String> get warehouseContact => $composableBuilder(
      column: $table.warehouseContact, builder: (column) => column);

  GeneratedColumn<String> get warehousePhrase => $composableBuilder(
      column: $table.warehousePhrase, builder: (column) => column);

  GeneratedColumn<int> get warehouseOwner => $composableBuilder(
      column: $table.warehouseOwner, builder: (column) => column);

  GeneratedColumn<bool> get canDiscount => $composableBuilder(
      column: $table.canDiscount, builder: (column) => column);

  GeneratedColumn<double> get maxDiscountPercent => $composableBuilder(
      column: $table.maxDiscountPercent, builder: (column) => column);

  GeneratedColumn<bool> get canEditPrice => $composableBuilder(
      column: $table.canEditPrice, builder: (column) => column);

  GeneratedColumn<bool> get canRefund =>
      $composableBuilder(column: $table.canRefund, builder: (column) => column);
}

class $$UserTableTableTableManager extends RootTableManager<
    _$PosLocalDatabase,
    $UserTableTable,
    UserTableData,
    $$UserTableTableFilterComposer,
    $$UserTableTableOrderingComposer,
    $$UserTableTableAnnotationComposer,
    $$UserTableTableCreateCompanionBuilder,
    $$UserTableTableUpdateCompanionBuilder,
    (
      UserTableData,
      BaseReferences<_$PosLocalDatabase, $UserTableTable, UserTableData>
    ),
    UserTableData,
    PrefetchHooks Function()> {
  $$UserTableTableTableManager(_$PosLocalDatabase db, $UserTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<String> phone = const Value.absent(),
            Value<String> limit = const Value.absent(),
            Value<String> dateJoined = const Value.absent(),
            Value<bool> limitExceeded = const Value.absent(),
            Value<String> image = const Value.absent(),
            Value<int?> warehouseId = const Value.absent(),
            Value<String> warehouseUuid = const Value.absent(),
            Value<String> warehouseShopName = const Value.absent(),
            Value<String> warehouseAddress = const Value.absent(),
            Value<String> warehouseContact = const Value.absent(),
            Value<String> warehousePhrase = const Value.absent(),
            Value<int> warehouseOwner = const Value.absent(),
            Value<bool> canDiscount = const Value.absent(),
            Value<double> maxDiscountPercent = const Value.absent(),
            Value<bool> canEditPrice = const Value.absent(),
            Value<bool> canRefund = const Value.absent(),
          }) =>
              UserTableCompanion(
            id: id,
            name: name,
            role: role,
            code: code,
            phone: phone,
            limit: limit,
            dateJoined: dateJoined,
            limitExceeded: limitExceeded,
            image: image,
            warehouseId: warehouseId,
            warehouseUuid: warehouseUuid,
            warehouseShopName: warehouseShopName,
            warehouseAddress: warehouseAddress,
            warehouseContact: warehouseContact,
            warehousePhrase: warehousePhrase,
            warehouseOwner: warehouseOwner,
            canDiscount: canDiscount,
            maxDiscountPercent: maxDiscountPercent,
            canEditPrice: canEditPrice,
            canRefund: canRefund,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<String> phone = const Value.absent(),
            Value<String> limit = const Value.absent(),
            Value<String> dateJoined = const Value.absent(),
            Value<bool> limitExceeded = const Value.absent(),
            Value<String> image = const Value.absent(),
            Value<int?> warehouseId = const Value.absent(),
            Value<String> warehouseUuid = const Value.absent(),
            Value<String> warehouseShopName = const Value.absent(),
            Value<String> warehouseAddress = const Value.absent(),
            Value<String> warehouseContact = const Value.absent(),
            Value<String> warehousePhrase = const Value.absent(),
            Value<int> warehouseOwner = const Value.absent(),
            Value<bool> canDiscount = const Value.absent(),
            Value<double> maxDiscountPercent = const Value.absent(),
            Value<bool> canEditPrice = const Value.absent(),
            Value<bool> canRefund = const Value.absent(),
          }) =>
              UserTableCompanion.insert(
            id: id,
            name: name,
            role: role,
            code: code,
            phone: phone,
            limit: limit,
            dateJoined: dateJoined,
            limitExceeded: limitExceeded,
            image: image,
            warehouseId: warehouseId,
            warehouseUuid: warehouseUuid,
            warehouseShopName: warehouseShopName,
            warehouseAddress: warehouseAddress,
            warehouseContact: warehouseContact,
            warehousePhrase: warehousePhrase,
            warehouseOwner: warehouseOwner,
            canDiscount: canDiscount,
            maxDiscountPercent: maxDiscountPercent,
            canEditPrice: canEditPrice,
            canRefund: canRefund,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserTableTableProcessedTableManager = ProcessedTableManager<
    _$PosLocalDatabase,
    $UserTableTable,
    UserTableData,
    $$UserTableTableFilterComposer,
    $$UserTableTableOrderingComposer,
    $$UserTableTableAnnotationComposer,
    $$UserTableTableCreateCompanionBuilder,
    $$UserTableTableUpdateCompanionBuilder,
    (
      UserTableData,
      BaseReferences<_$PosLocalDatabase, $UserTableTable, UserTableData>
    ),
    UserTableData,
    PrefetchHooks Function()>;
typedef $$AuthTableTableCreateCompanionBuilder = AuthTableCompanion Function({
  required String accessToken,
  required String refreshToken,
  required int userId,
  Value<int> rowid,
});
typedef $$AuthTableTableUpdateCompanionBuilder = AuthTableCompanion Function({
  Value<String> accessToken,
  Value<String> refreshToken,
  Value<int> userId,
  Value<int> rowid,
});

class $$AuthTableTableFilterComposer
    extends Composer<_$PosLocalDatabase, $AuthTableTable> {
  $$AuthTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get accessToken => $composableBuilder(
      column: $table.accessToken, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get refreshToken => $composableBuilder(
      column: $table.refreshToken, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));
}

class $$AuthTableTableOrderingComposer
    extends Composer<_$PosLocalDatabase, $AuthTableTable> {
  $$AuthTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get accessToken => $composableBuilder(
      column: $table.accessToken, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get refreshToken => $composableBuilder(
      column: $table.refreshToken,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));
}

class $$AuthTableTableAnnotationComposer
    extends Composer<_$PosLocalDatabase, $AuthTableTable> {
  $$AuthTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get accessToken => $composableBuilder(
      column: $table.accessToken, builder: (column) => column);

  GeneratedColumn<String> get refreshToken => $composableBuilder(
      column: $table.refreshToken, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);
}

class $$AuthTableTableTableManager extends RootTableManager<
    _$PosLocalDatabase,
    $AuthTableTable,
    AuthTableData,
    $$AuthTableTableFilterComposer,
    $$AuthTableTableOrderingComposer,
    $$AuthTableTableAnnotationComposer,
    $$AuthTableTableCreateCompanionBuilder,
    $$AuthTableTableUpdateCompanionBuilder,
    (
      AuthTableData,
      BaseReferences<_$PosLocalDatabase, $AuthTableTable, AuthTableData>
    ),
    AuthTableData,
    PrefetchHooks Function()> {
  $$AuthTableTableTableManager(_$PosLocalDatabase db, $AuthTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuthTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuthTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuthTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> accessToken = const Value.absent(),
            Value<String> refreshToken = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AuthTableCompanion(
            accessToken: accessToken,
            refreshToken: refreshToken,
            userId: userId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String accessToken,
            required String refreshToken,
            required int userId,
            Value<int> rowid = const Value.absent(),
          }) =>
              AuthTableCompanion.insert(
            accessToken: accessToken,
            refreshToken: refreshToken,
            userId: userId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AuthTableTableProcessedTableManager = ProcessedTableManager<
    _$PosLocalDatabase,
    $AuthTableTable,
    AuthTableData,
    $$AuthTableTableFilterComposer,
    $$AuthTableTableOrderingComposer,
    $$AuthTableTableAnnotationComposer,
    $$AuthTableTableCreateCompanionBuilder,
    $$AuthTableTableUpdateCompanionBuilder,
    (
      AuthTableData,
      BaseReferences<_$PosLocalDatabase, $AuthTableTable, AuthTableData>
    ),
    AuthTableData,
    PrefetchHooks Function()>;
typedef $$ProductTableTableCreateCompanionBuilder = ProductTableCompanion
    Function({
  Value<int> id,
  required String title,
  required String cost,
  required String price,
  Value<String> wholesalePrice,
  required String stock,
  required String categoryTitle,
  required String unit,
  Value<int?> packSize,
  Value<String> meterPrice,
  required String qrcode,
  required int warehouse,
  required String images,
});
typedef $$ProductTableTableUpdateCompanionBuilder = ProductTableCompanion
    Function({
  Value<int> id,
  Value<String> title,
  Value<String> cost,
  Value<String> price,
  Value<String> wholesalePrice,
  Value<String> stock,
  Value<String> categoryTitle,
  Value<String> unit,
  Value<int?> packSize,
  Value<String> meterPrice,
  Value<String> qrcode,
  Value<int> warehouse,
  Value<String> images,
});

class $$ProductTableTableFilterComposer
    extends Composer<_$PosLocalDatabase, $ProductTableTable> {
  $$ProductTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cost => $composableBuilder(
      column: $table.cost, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get wholesalePrice => $composableBuilder(
      column: $table.wholesalePrice,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get stock => $composableBuilder(
      column: $table.stock, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoryTitle => $composableBuilder(
      column: $table.categoryTitle, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get packSize => $composableBuilder(
      column: $table.packSize, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get meterPrice => $composableBuilder(
      column: $table.meterPrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get qrcode => $composableBuilder(
      column: $table.qrcode, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get warehouse => $composableBuilder(
      column: $table.warehouse, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get images => $composableBuilder(
      column: $table.images, builder: (column) => ColumnFilters(column));
}

class $$ProductTableTableOrderingComposer
    extends Composer<_$PosLocalDatabase, $ProductTableTable> {
  $$ProductTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cost => $composableBuilder(
      column: $table.cost, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get wholesalePrice => $composableBuilder(
      column: $table.wholesalePrice,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stock => $composableBuilder(
      column: $table.stock, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoryTitle => $composableBuilder(
      column: $table.categoryTitle,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get packSize => $composableBuilder(
      column: $table.packSize, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get meterPrice => $composableBuilder(
      column: $table.meterPrice, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get qrcode => $composableBuilder(
      column: $table.qrcode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get warehouse => $composableBuilder(
      column: $table.warehouse, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get images => $composableBuilder(
      column: $table.images, builder: (column) => ColumnOrderings(column));
}

class $$ProductTableTableAnnotationComposer
    extends Composer<_$PosLocalDatabase, $ProductTableTable> {
  $$ProductTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumn<String> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get wholesalePrice => $composableBuilder(
      column: $table.wholesalePrice, builder: (column) => column);

  GeneratedColumn<String> get stock =>
      $composableBuilder(column: $table.stock, builder: (column) => column);

  GeneratedColumn<String> get categoryTitle => $composableBuilder(
      column: $table.categoryTitle, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get packSize =>
      $composableBuilder(column: $table.packSize, builder: (column) => column);

  GeneratedColumn<String> get meterPrice => $composableBuilder(
      column: $table.meterPrice, builder: (column) => column);

  GeneratedColumn<String> get qrcode =>
      $composableBuilder(column: $table.qrcode, builder: (column) => column);

  GeneratedColumn<int> get warehouse =>
      $composableBuilder(column: $table.warehouse, builder: (column) => column);

  GeneratedColumn<String> get images =>
      $composableBuilder(column: $table.images, builder: (column) => column);
}

class $$ProductTableTableTableManager extends RootTableManager<
    _$PosLocalDatabase,
    $ProductTableTable,
    ProductTableData,
    $$ProductTableTableFilterComposer,
    $$ProductTableTableOrderingComposer,
    $$ProductTableTableAnnotationComposer,
    $$ProductTableTableCreateCompanionBuilder,
    $$ProductTableTableUpdateCompanionBuilder,
    (
      ProductTableData,
      BaseReferences<_$PosLocalDatabase, $ProductTableTable, ProductTableData>
    ),
    ProductTableData,
    PrefetchHooks Function()> {
  $$ProductTableTableTableManager(
      _$PosLocalDatabase db, $ProductTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> cost = const Value.absent(),
            Value<String> price = const Value.absent(),
            Value<String> wholesalePrice = const Value.absent(),
            Value<String> stock = const Value.absent(),
            Value<String> categoryTitle = const Value.absent(),
            Value<String> unit = const Value.absent(),
            Value<int?> packSize = const Value.absent(),
            Value<String> meterPrice = const Value.absent(),
            Value<String> qrcode = const Value.absent(),
            Value<int> warehouse = const Value.absent(),
            Value<String> images = const Value.absent(),
          }) =>
              ProductTableCompanion(
            id: id,
            title: title,
            cost: cost,
            price: price,
            wholesalePrice: wholesalePrice,
            stock: stock,
            categoryTitle: categoryTitle,
            unit: unit,
            packSize: packSize,
            meterPrice: meterPrice,
            qrcode: qrcode,
            warehouse: warehouse,
            images: images,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String cost,
            required String price,
            Value<String> wholesalePrice = const Value.absent(),
            required String stock,
            required String categoryTitle,
            required String unit,
            Value<int?> packSize = const Value.absent(),
            Value<String> meterPrice = const Value.absent(),
            required String qrcode,
            required int warehouse,
            required String images,
          }) =>
              ProductTableCompanion.insert(
            id: id,
            title: title,
            cost: cost,
            price: price,
            wholesalePrice: wholesalePrice,
            stock: stock,
            categoryTitle: categoryTitle,
            unit: unit,
            packSize: packSize,
            meterPrice: meterPrice,
            qrcode: qrcode,
            warehouse: warehouse,
            images: images,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProductTableTableProcessedTableManager = ProcessedTableManager<
    _$PosLocalDatabase,
    $ProductTableTable,
    ProductTableData,
    $$ProductTableTableFilterComposer,
    $$ProductTableTableOrderingComposer,
    $$ProductTableTableAnnotationComposer,
    $$ProductTableTableCreateCompanionBuilder,
    $$ProductTableTableUpdateCompanionBuilder,
    (
      ProductTableData,
      BaseReferences<_$PosLocalDatabase, $ProductTableTable, ProductTableData>
    ),
    ProductTableData,
    PrefetchHooks Function()>;
typedef $$CategoryTableTableCreateCompanionBuilder = CategoryTableCompanion
    Function({
  Value<int> id,
  required String title,
  required String image,
});
typedef $$CategoryTableTableUpdateCompanionBuilder = CategoryTableCompanion
    Function({
  Value<int> id,
  Value<String> title,
  Value<String> image,
});

class $$CategoryTableTableFilterComposer
    extends Composer<_$PosLocalDatabase, $CategoryTableTable> {
  $$CategoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnFilters(column));
}

class $$CategoryTableTableOrderingComposer
    extends Composer<_$PosLocalDatabase, $CategoryTableTable> {
  $$CategoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnOrderings(column));
}

class $$CategoryTableTableAnnotationComposer
    extends Composer<_$PosLocalDatabase, $CategoryTableTable> {
  $$CategoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);
}

class $$CategoryTableTableTableManager extends RootTableManager<
    _$PosLocalDatabase,
    $CategoryTableTable,
    CategoryTableData,
    $$CategoryTableTableFilterComposer,
    $$CategoryTableTableOrderingComposer,
    $$CategoryTableTableAnnotationComposer,
    $$CategoryTableTableCreateCompanionBuilder,
    $$CategoryTableTableUpdateCompanionBuilder,
    (
      CategoryTableData,
      BaseReferences<_$PosLocalDatabase, $CategoryTableTable, CategoryTableData>
    ),
    CategoryTableData,
    PrefetchHooks Function()> {
  $$CategoryTableTableTableManager(
      _$PosLocalDatabase db, $CategoryTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> image = const Value.absent(),
          }) =>
              CategoryTableCompanion(
            id: id,
            title: title,
            image: image,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String image,
          }) =>
              CategoryTableCompanion.insert(
            id: id,
            title: title,
            image: image,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CategoryTableTableProcessedTableManager = ProcessedTableManager<
    _$PosLocalDatabase,
    $CategoryTableTable,
    CategoryTableData,
    $$CategoryTableTableFilterComposer,
    $$CategoryTableTableOrderingComposer,
    $$CategoryTableTableAnnotationComposer,
    $$CategoryTableTableCreateCompanionBuilder,
    $$CategoryTableTableUpdateCompanionBuilder,
    (
      CategoryTableData,
      BaseReferences<_$PosLocalDatabase, $CategoryTableTable, CategoryTableData>
    ),
    CategoryTableData,
    PrefetchHooks Function()>;
typedef $$PendingTransactionsTableCreateCompanionBuilder
    = PendingTransactionsCompanion Function({
  Value<int> id,
  required String payload,
  Value<DateTime> createdAt,
});
typedef $$PendingTransactionsTableUpdateCompanionBuilder
    = PendingTransactionsCompanion Function({
  Value<int> id,
  Value<String> payload,
  Value<DateTime> createdAt,
});

class $$PendingTransactionsTableFilterComposer
    extends Composer<_$PosLocalDatabase, $PendingTransactionsTable> {
  $$PendingTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$PendingTransactionsTableOrderingComposer
    extends Composer<_$PosLocalDatabase, $PendingTransactionsTable> {
  $$PendingTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$PendingTransactionsTableAnnotationComposer
    extends Composer<_$PosLocalDatabase, $PendingTransactionsTable> {
  $$PendingTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PendingTransactionsTableTableManager extends RootTableManager<
    _$PosLocalDatabase,
    $PendingTransactionsTable,
    PendingTransaction,
    $$PendingTransactionsTableFilterComposer,
    $$PendingTransactionsTableOrderingComposer,
    $$PendingTransactionsTableAnnotationComposer,
    $$PendingTransactionsTableCreateCompanionBuilder,
    $$PendingTransactionsTableUpdateCompanionBuilder,
    (
      PendingTransaction,
      BaseReferences<_$PosLocalDatabase, $PendingTransactionsTable,
          PendingTransaction>
    ),
    PendingTransaction,
    PrefetchHooks Function()> {
  $$PendingTransactionsTableTableManager(
      _$PosLocalDatabase db, $PendingTransactionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PendingTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PendingTransactionsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PendingTransactionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> payload = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              PendingTransactionsCompanion(
            id: id,
            payload: payload,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String payload,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              PendingTransactionsCompanion.insert(
            id: id,
            payload: payload,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PendingTransactionsTableProcessedTableManager = ProcessedTableManager<
    _$PosLocalDatabase,
    $PendingTransactionsTable,
    PendingTransaction,
    $$PendingTransactionsTableFilterComposer,
    $$PendingTransactionsTableOrderingComposer,
    $$PendingTransactionsTableAnnotationComposer,
    $$PendingTransactionsTableCreateCompanionBuilder,
    $$PendingTransactionsTableUpdateCompanionBuilder,
    (
      PendingTransaction,
      BaseReferences<_$PosLocalDatabase, $PendingTransactionsTable,
          PendingTransaction>
    ),
    PendingTransaction,
    PrefetchHooks Function()>;
typedef $$PrinterSettingsTableTableCreateCompanionBuilder
    = PrinterSettingsTableCompanion Function({
  Value<int> id,
  Value<String?> printerName,
  Value<String?> barcodePrinterName,
});
typedef $$PrinterSettingsTableTableUpdateCompanionBuilder
    = PrinterSettingsTableCompanion Function({
  Value<int> id,
  Value<String?> printerName,
  Value<String?> barcodePrinterName,
});

class $$PrinterSettingsTableTableFilterComposer
    extends Composer<_$PosLocalDatabase, $PrinterSettingsTableTable> {
  $$PrinterSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get printerName => $composableBuilder(
      column: $table.printerName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get barcodePrinterName => $composableBuilder(
      column: $table.barcodePrinterName,
      builder: (column) => ColumnFilters(column));
}

class $$PrinterSettingsTableTableOrderingComposer
    extends Composer<_$PosLocalDatabase, $PrinterSettingsTableTable> {
  $$PrinterSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get printerName => $composableBuilder(
      column: $table.printerName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get barcodePrinterName => $composableBuilder(
      column: $table.barcodePrinterName,
      builder: (column) => ColumnOrderings(column));
}

class $$PrinterSettingsTableTableAnnotationComposer
    extends Composer<_$PosLocalDatabase, $PrinterSettingsTableTable> {
  $$PrinterSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get printerName => $composableBuilder(
      column: $table.printerName, builder: (column) => column);

  GeneratedColumn<String> get barcodePrinterName => $composableBuilder(
      column: $table.barcodePrinterName, builder: (column) => column);
}

class $$PrinterSettingsTableTableTableManager extends RootTableManager<
    _$PosLocalDatabase,
    $PrinterSettingsTableTable,
    PrinterSettingsTableData,
    $$PrinterSettingsTableTableFilterComposer,
    $$PrinterSettingsTableTableOrderingComposer,
    $$PrinterSettingsTableTableAnnotationComposer,
    $$PrinterSettingsTableTableCreateCompanionBuilder,
    $$PrinterSettingsTableTableUpdateCompanionBuilder,
    (
      PrinterSettingsTableData,
      BaseReferences<_$PosLocalDatabase, $PrinterSettingsTableTable,
          PrinterSettingsTableData>
    ),
    PrinterSettingsTableData,
    PrefetchHooks Function()> {
  $$PrinterSettingsTableTableTableManager(
      _$PosLocalDatabase db, $PrinterSettingsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrinterSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrinterSettingsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrinterSettingsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> printerName = const Value.absent(),
            Value<String?> barcodePrinterName = const Value.absent(),
          }) =>
              PrinterSettingsTableCompanion(
            id: id,
            printerName: printerName,
            barcodePrinterName: barcodePrinterName,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> printerName = const Value.absent(),
            Value<String?> barcodePrinterName = const Value.absent(),
          }) =>
              PrinterSettingsTableCompanion.insert(
            id: id,
            printerName: printerName,
            barcodePrinterName: barcodePrinterName,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PrinterSettingsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$PosLocalDatabase,
        $PrinterSettingsTableTable,
        PrinterSettingsTableData,
        $$PrinterSettingsTableTableFilterComposer,
        $$PrinterSettingsTableTableOrderingComposer,
        $$PrinterSettingsTableTableAnnotationComposer,
        $$PrinterSettingsTableTableCreateCompanionBuilder,
        $$PrinterSettingsTableTableUpdateCompanionBuilder,
        (
          PrinterSettingsTableData,
          BaseReferences<_$PosLocalDatabase, $PrinterSettingsTableTable,
              PrinterSettingsTableData>
        ),
        PrinterSettingsTableData,
        PrefetchHooks Function()>;

class $PosLocalDatabaseManager {
  final _$PosLocalDatabase _db;
  $PosLocalDatabaseManager(this._db);
  $$UserTableTableTableManager get userTable =>
      $$UserTableTableTableManager(_db, _db.userTable);
  $$AuthTableTableTableManager get authTable =>
      $$AuthTableTableTableManager(_db, _db.authTable);
  $$ProductTableTableTableManager get productTable =>
      $$ProductTableTableTableManager(_db, _db.productTable);
  $$CategoryTableTableTableManager get categoryTable =>
      $$CategoryTableTableTableManager(_db, _db.categoryTable);
  $$PendingTransactionsTableTableManager get pendingTransactions =>
      $$PendingTransactionsTableTableManager(_db, _db.pendingTransactions);
  $$PrinterSettingsTableTableTableManager get printerSettingsTable =>
      $$PrinterSettingsTableTableTableManager(_db, _db.printerSettingsTable);
}
