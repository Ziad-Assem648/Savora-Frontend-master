import 'package:flutter/material.dart';

class LanguageManager {
  static bool isArabic = true;

  static TextDirection get textDirection =>
      isArabic ? TextDirection.rtl : TextDirection.ltr;

  static void setLanguage(bool arabic) {
    isArabic = arabic;
  }
}
