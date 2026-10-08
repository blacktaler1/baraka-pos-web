import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';

/// PDF faylni telefonning "Ulashish" oynasi orqali yuboradi (Telegram, WhatsApp...).
/// Brauzer Web Share API'ni qo'llamasa — fayl yuklab olinadi.
///
/// Muhim: brauzer ulashishni faqat foydalanuvchi bosgan zahoti ruxsat beradi,
/// shuning uchun PDF oldindan tayyorlanib, tugma bosilganda shu funksiya chaqiriladi.
Future<void> sharePdfBytes(Uint8List bytes, String fileName) =>
    shareFileBytes(bytes, fileName, 'application/pdf');

/// Istalgan faylni (Excel, PDF) ulashish yoki yuklab olish
Future<void> shareFileBytes(
  Uint8List bytes,
  String fileName,
  String mimeType,
) async {
  await SharePlus.instance.share(
    ShareParams(
      files: [XFile.fromData(bytes, mimeType: mimeType, name: fileName)],
      fileNameOverrides: [fileName],
      title: fileName,
      downloadFallbackEnabled: true,
    ),
  );
}
