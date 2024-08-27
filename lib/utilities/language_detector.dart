import 'package:flutter/foundation.dart';

class LanguageDetector {
  void exampleLanguageDetector() {
    String sampleText1 = 'مرحبا بكم'; // Arabic
    String sampleText2 = 'Hello World'; // English
    String sampleText3 = 'مرحبا Hello'; // Mixed

    if (kDebugMode) {
      print('Language Detection 1: ${detectLanguage(sampleText1)}'); // Arabic
      print('Language Detection 2: ${detectLanguage(sampleText2)}'); // English
      print('Language Detection 3: ${detectLanguage(sampleText3)}'); // Mixed
    }
  }

  String detectLanguage(String text) {
    bool hasArabic = containsArabic(text);
    bool hasEnglish = containsEnglish(text);

    if (hasArabic && hasEnglish) {
      return 'Mixed';
    } else if (hasArabic) {
      return 'Arabic';
    } else if (hasEnglish) {
      return 'English';
    } else {
      return 'Unknown';
    }
  }

  bool containsArabic(String text) {
    return RegExp(r'[\u0600-\u06FF]').hasMatch(text);
  }

  bool containsEnglish(String text) {
    return RegExp(r'[\u0041-\u005A\u0061-\u007A]').hasMatch(text);
    // return RegExp(r'[A-Za-z]').hasMatch(text);
  }

  bool isArabic(String text) {
    final arabicRange = RegExp(r'[\u0600-\u06FF]');
    return arabicRange.hasMatch(text);
  }

  bool isEnglish(String text) {
    final englishRange = RegExp(r'[\u0041-\u005A\u0061-\u007A\u0020-\u007E]');
    // final englishRange = RegExp(r'[A-Za-z]');
    return englishRange.hasMatch(text);
  }
}
