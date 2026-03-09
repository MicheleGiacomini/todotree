import 'package:flutter/material.dart';

class TagPalette {
  static const List<Color> baseColors = [
    Color(0xFFFFFFFF), // White
    Color(0xFF343A40), // Dark Gray (default)
    Color(0xFFC92A2A), // Red
    Color(0xFFE67700), // Orange
    Color(0xFFEAB308), // Yellow
    Color(0xFF2F9E44), // Green
    Color(0xFF0891B2), // Cyan
    Color(0xFF2563EB), // Blue
    Color(0xFF7C3AED), // Violet
    Color(0xFFDB2777), // Pink
  ];

  static const Map<int, List<Color>> shades = {
    0xFF343A40: [
      Color(0xFFF8F9FA),
      Color(0xFFDEE2E6),
      Color(0xFFADB5BD),
      Color(0xFF495057),
      Color(0xFF343A40),
    ],
    0xFFC92A2A: [
      Color(0xFFFFF5F5),
      Color(0xFFFFC9C9),
      Color(0xFFFA5252),
      Color(0xFFE03131),
      Color(0xFFC92A2A),
    ],
    0xFFE67700: [
      Color(0xFFFFF4E6),
      Color(0xFFFFD8A8),
      Color(0xFFFD7E14),
      Color(0xFFE67E22),
      Color(0xFFE67700),
    ],
    0xFFEAB308: [
      Color(0xFFFEFCE8),
      Color(0xFFFEF08A),
      Color(0xFFFACC15),
      Color(0xFFEAB308),
      Color(0xFFA16207),
    ],
    0xFF2F9E44: [
      Color(0xFFEBFBEE),
      Color(0xFFB2F2BB),
      Color(0xFF51CF66),
      Color(0xFF37B24D),
      Color(0xFF2F9E44),
    ],
    0xFF0891B2: [
      Color(0xFFECFEFF),
      Color(0xFFA5F3FC),
      Color(0xFF22D3EE),
      Color(0xFF0891B2),
      Color(0xFF155E75),
    ],
    0xFF2563EB: [
      Color(0xFFEFF6FF),
      Color(0xFFBFDBFE),
      Color(0xFF3B82F6),
      Color(0xFF2563EB),
      Color(0xFF1E40AF),
    ],
    0xFF7C3AED: [
      Color(0xFFF5F3FF),
      Color(0xFFDDD6FE),
      Color(0xFFA78BFA),
      Color(0xFF7C3AED),
      Color(0xFF5B21B6),
    ],
    0xFFDB2777: [
      Color(0xFFFDF2F8),
      Color(0xFFFBCFE8),
      Color(0xFFF472B6),
      Color(0xFFDB2777),
      Color(0xFF9D174D),
    ],
  };

  static List<Color>? getShades(Color baseColor) {
    return shades[baseColor.toARGB32()];
  }

  static Color getColor(int? value) {
    if (value == null) return baseColors[1];
    return Color(value);
  }

  static Color getContrastColor(Color background) {
    return background.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
