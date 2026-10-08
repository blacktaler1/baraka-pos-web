import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ThousandsSeparatorFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;
    final String cleanText = newValue.text.replaceAll(' ', '');
    final chars = cleanText.characters.toList();
    String formatted = "";

    for (int i = 0; i < chars.length; i++) {
      formatted += chars[i];
      int pos = chars.length - i - 1;
      if (pos % 3 == 0 && pos != 0) {
        formatted += " ";
      }
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
