import 'package:package_info_plus/package_info_plus.dart';

Future<String> getProjectVersion() async {
  final info = await PackageInfo.fromPlatform();
  return info.version;
}

// Versiyalarni solishtirish
int compareVersions(String v1, String v2) {
  final a = v1.split('.').map(int.parse).toList();
  final b = v2.split('.').map(int.parse).toList();
  final maxLen = a.length > b.length ? a.length : b.length;
  for (int i = 0; i < maxLen; i++) {
    final x = i < a.length ? a[i] : 0;
    final y = i < b.length ? b[i] : 0;
    if (x > y) return 1;
    if (x < y) return -1;
  }
  return 0;
}
