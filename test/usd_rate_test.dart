import 'package:baraka_pos/shared/aplication/utils/usd_rate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("dollar so'mga o'tkazilib, butun so'mgacha yaxlitlanadi", () {
    expect(UsdRate.toSom(1, 59000.777777), 59001);
    expect(UsdRate.toSom(1, 59000.4), 59000);
    expect(UsdRate.toSom(4.75, 12650), 60088); // 60087.5 -> 60088
    expect(UsdRate.toSom(100, 12650), 1265000);
  });
}
