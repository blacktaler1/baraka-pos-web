import 'package:baraka_pos/features/auth/data/dto/dto.dart';
import 'package:baraka_pos/features/cash/data/dto/_dto.dart';
import 'package:baraka_pos/features/debtors/data/dto/_dto.dart';
import 'package:baraka_pos/features/debtors/data/dto/customer_dto.dart';
import 'package:baraka_pos/features/debtors/data/dto/get_customer_dto.dart';
import 'package:baraka_pos/features/expenses/data/dto/_dto.dart';
import 'package:baraka_pos/features/firma/data/dto/dto.dart';
import 'package:baraka_pos/features/global/data/dto/dto.dart';
import 'package:baraka_pos/features/home/data/dto/dto.dart';
import 'package:baraka_pos/features/media/data/dto/dto.dart';
import 'package:baraka_pos/features/settings/data/dto/dto.dart';
import 'package:baraka_pos/features/store/data/dto/dto.dart';
import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:flutter_test/flutter_test.dart';

typedef DtoBuilder = Object Function(Json json);

final Map<String, DtoBuilder> dtoBuilders = {
  'ProductDto': (j) => ProductDto.fromJson(j).model(),
  'AllProductDto': (j) => AllProductDto.fromJson(j).model(),
  'GlobalProductItemDto': (j) => GlobalProductItemDto.fromJson(j).model(),
  'FirmaDto': (j) => FirmaDto.fromJson(j).model(),
  'AllFirmaDto': (j) => AllFirmaDto.fromJson(j).model(),
  'LoanFirmaDto': (j) => LoanFirmaDto.fromJson(j).model(),
  'AllLoanDto': (j) => AllLoanDto.fromJson(j).model(),
  'TransactionDto': (j) => TransactionDto.fromJson(j).model(),
  'TransactionItemDto': (j) => TransactionItemDto.fromJson(j).model(),
  'AllTransactionDto': (j) => AllTransactionDto.fromJson(j).model(),
  'CashProductDto': (j) => CashProductDto.fromJson(j).model(),
  'AllCashProductDto': (j) => AllCashProductDto.fromJson(j).model(),
  'DailyChecksDto': (j) => DailyChecksDto.fromJson(j).model(),
  'GetRefundDto': (j) => GetRefundDto.fromJson(j).model(),
  'AllRefundsDto': (j) => AllRefundsDto.fromJson(j).model(),
  'CashierDto': (j) => CashierDto.fromJson(j).model(),
  'DebtorsItemDto': (j) => DebtorsItemDto.fromJson(j).model(),
  'DebtorsListDto': (j) => DebtorsListDto.fromJson(j).model(),
  'CustomerDto': (j) => CustomerDto.fromJson(j).model(),
  'GetCustomerDto': (j) => GetCustomerDto.fromJson(j).model(),
  'ItemDto': (j) => ItemDto.fromJson(j).model(),
  'ByCustomerItemDto': (j) => ByCustomerItemDto.fromJson(j).model(),
  'ByCustomerHistoryDto': (j) => ByCustomerHistoryDto.fromJson(j).model(),
  'TransactionDetailsDto': (j) => TransactionDetailsDto.fromJson(j).model(),
  'PayDebtDto': (j) => PayDebtDto.fromJson(j).model(),
  'CardItemDto': (j) => CardItemDto.fromJson(j).model(),
  'CardsDto': (j) => CardsDto.fromJson(j).model(),
  'ChartDto': (j) => ChartDto.fromJson(j).model(),
  'DashboardDto': (j) => DashboardDto.fromJson(j).model(),
  'TurnoverCardDto': (j) => TurnoverCardDto.fromJson(j).model(),
  'UserDto': (j) => UserDto.fromJson(j).model(),
  'LoginDto': (j) => LoginDto.fromJson(j).model(),
  'WarehouseDto': (j) => WarehouseDto.fromJson(j).model(),
  'ImageDto': (j) => ImageDto.fromJson(j).model(),
  'CategoryDto': (j) => CategoryDto.fromJson(j).model(),
  'GetCategoryDto': (j) => GetCategoryDto.fromJson(j).model(),
  'DeviceDto': (j) => DeviceDto.fromJson(j).model(),
  'ExpenseDto': (j) => ExpenseDto.fromJson(j).model(),
  'GetExpensesDto': (j) => GetExpensesDto.fromJson(j).model(),
  'MediaDto': (j) => MediaDto.fromJson(j).model(),
  'LastVersionDto': (j) => LastVersionDto.fromJson(j).model(),
  'UpdateShopInfoDto': (j) => UpdateShopInfoDto.fromJson(j).model(),
  'ChangePasswordDto': (j) => ChangePasswordDto.fromJson(j).model(),
};

const hostileNumericKeys = [
  'id',
  'total',
  'price',
  'cost',
  'stock',
  'margin',
  'amount',
  'percentage',
  'quantity',
  'subtotal',
  'paid',
  'debt',
  'total_sum',
  'total_cash',
  'total_card',
  'total_debt',
  'total_paid',
  'total_num',
  'total_price',
  'total_sales',
  'total_quantity',
  'total_amount',
  'total_stock_value',
  'grand_total_sum',
  'remainder',
  'profit',
  'pack_size',
  'warehouse',
  'owner',
  'customer',
  'transaction',
  'user',
  'unpaid_records_count',
  'total_products',
];

Json buildHostileJson(Object? valueForEveryKey) {
  final json = <String, dynamic>{};
  for (final key in hostileNumericKeys) {
    json[key] = valueForEveryKey;
  }
  for (final key in ['title', 'name', 'full_name', 'unit', 'qr_code']) {
    json[key] = valueForEveryKey;
  }
  return json;
}

void main() {
  group('parseAmount', () {
    test('bo\'sh va noto\'g\'ri kiritishda yiqilmaydi', () {
      expect(parseAmount(''), 0);
      expect(parseAmount(null), 0);
      expect(parseAmount('abc'), 0);
      expect(parseAmount('   '), 0);
    });

    test('ming ajratgich va vergul-kasrni tushunadi', () {
      expect(parseAmount('12 000'), 12000);
      expect(parseAmount('1,5'), 1.5);
      expect(parseAmount('1.5'), 1.5);
      expect(parseAmount('23.000'), 23);
    });

    test('parseAmountInt butun son qaytaradi', () {
      expect(parseAmountInt('12 000'), 12000);
      expect(parseAmountInt(''), 0);
      expect(parseAmountInt('abc', fallback: 1), 1);
    });
  });

  group('SafeJsonRead', () {
    test('yo\'q kalitda fallback qaytaradi', () {
      final Json empty = {};
      expect(empty.text('x'), '');
      expect(empty.integer('x'), 0);
      expect(empty.number('x'), 0);
      expect(empty.flag('x'), false);
      expect(empty.object('x'), <String, dynamic>{});
      expect(empty.items('x'), isEmpty);
    });

    test('matn ko\'rinishidagi sonni songa aylantiradi', () {
      final Json json = {'a': '10.00', 'b': '55'};
      expect(json.number('a'), 10.0);
      expect(json.integer('b'), 55);
    });

    test('son ko\'rinishidagi qiymatni matnga aylantiradi', () {
      final Json json = {'a': 42};
      expect(json.text('a'), '42');
    });

    test('noto\'g\'ri tipda ham yiqilmaydi', () {
      final Json json = {'a': [], 'b': {}, 'c': true};
      expect(json.integer('a'), 0);
      expect(json.number('b'), 0);
      expect(json.text('c'), 'true');
      expect(json.items('b'), isEmpty);
      expect(json.object('a'), <String, dynamic>{});
    });
  });

  group('DTO bo\'sh JSON bilan yiqilmaydi', () {
    for (final entry in dtoBuilders.entries) {
      test(entry.key, () {
        expect(() => entry.value(<String, dynamic>{}), returnsNormally);
      });
    }
  });

  group('DTO barcha maydon null bo\'lganda yiqilmaydi', () {
    for (final entry in dtoBuilders.entries) {
      test(entry.key, () {
        expect(() => entry.value(buildHostileJson(null)), returnsNormally);
      });
    }
  });

  group('DTO son o\'rniga matn kelganda yiqilmaydi', () {
    for (final entry in dtoBuilders.entries) {
      test(entry.key, () {
        expect(() => entry.value(buildHostileJson('10.00')), returnsNormally);
      });
    }
  });

  group('DTO matn o\'rniga son kelganda yiqilmaydi', () {
    for (final entry in dtoBuilders.entries) {
      test(entry.key, () {
        expect(() => entry.value(buildHostileJson(7)), returnsNormally);
      });
    }
  });

  test('haqiqiy /product/ javobi to\'liq o\'qiladi', () {
    final Json response = {
      "next": "cD0yMDI2",
      "previous": null,
      "total": 39,
      "total_stock_value": 49870.0,
      "data": [
        {
          "id": 1198,
          "title": "test12",
          "cost": "10.00",
          "price": "20.00",
          "margin": 10.0,
          "stock": "23.000",
          "category": {
            "id": 111,
            "title": "Vicherniy",
            "images": [],
            "created": "2026-02-09T13:54:29.600000+05:00",
            "modified": "2026-02-09T13:54:29.600000+05:00",
          },
          "unit": "dona",
          "pack_size": null,
          "images": [],
          "qr_code": "83266492",
          "warehouse": 25,
          "firma": {
            "id": 55,
            "title": "Azimjon romol",
            "phone": "+998773338888",
            "address": "Raxmat fayzi 46",
            "warehouse": 25,
            "images": [],
            "created": "2026-02-08T20:01:31.230000+05:00",
            "modified": "2026-02-08T20:01:31.230000+05:00",
            "deleted_at": null,
          },
          "created": "2026-08-17T19:33:33.378978+05:00",
          "modified": "2026-08-17T19:33:33.378978+05:00",
          "deleted_at": null,
        },
        {
          "id": 638,
          "title": "spartivka dvoyka",
          "cost": "70.00",
          "price": "100.00",
          "margin": 30.0,
          "stock": "3.000",
          "category": {"id": 98, "title": "Кундалик либослар", "images": []},
          "unit": "dona",
          "pack_size": null,
          "images": [],
          "qr_code": "04431004",
          "warehouse": 25,
          "firma": null,
          "created": "2026-02-22T14:21:26.794545+05:00",
          "modified": "2026-02-22T14:21:26.794545+05:00",
          "deleted_at": null,
        },
      ],
    };

    final model = AllProductDto.fromJson(response).model();

    expect(model.total, 39);
    expect(model.collection.models.length, 2);
    expect(model.collection.models.first.title, 'test12');
    expect(model.collection.models.first.stock, '23.0');
    expect(model.collection.models.first.firma?.title, 'Azimjon romol');
    expect(model.collection.models.first.firma?.totalDebt, 0);
    expect(model.collection.models.last.firma, isNull);
  });
}
