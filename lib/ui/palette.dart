import 'package:flutter/material.dart';

class TagPalette {
  static const List<Color> colors = [
    Color(0xFFADB5BD), // Gray
    Color(0xFFFF8787), // Red
    Color(0xFFF783AC), // Pink
    Color(0xFFDA77F2), // Grape
    Color(0xFF9775FA), // Violet
    Color(0xFF748FFC), // Indigo
    Color(0xFF4DABF7), // Blue
    Color(0xFF3BC9DB), // Cyan
    Color(0xFF38D9A9), // Teal
    Color(0xFF69DB7C), // Green
    Color(0xFFA9E34B), // Green-Yellow
    Color(0xFFFFD43B), // Yellow
    Color(0xFFFFA94D), // Orange
    Color(0xFFFF922B), // Deep Orange
  ];

  static Color getColor(int? value) {
    if (value == null) return colors[0];
    return Color(value);
  }

  static Color getContrastColor(Color background) {
    return background.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
