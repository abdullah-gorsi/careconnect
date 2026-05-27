import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF586BFF);
  static const Color secondary = Color(0xFF23D2B5);
  static const Color accent = Color(0xFFFF8A65);
  static const Color background = Color(0xFFF4F6FE);
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF60708F);

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF586BFF), Color(0xFF23D2B5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient softBackground = LinearGradient(
    colors: [Color(0xFFEEF1FF), Color(0xFFFDF7F4), Color(0xFFEFFCF8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
