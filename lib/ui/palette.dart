import 'package:flutter/material.dart';

enum SemanticColor {
  // Standard Terminal Colors
  black,
  red,
  green,
  yellow,
  blue,
  magenta,
  cyan,
  white,
  // Bright variants
  brightBlack,
  brightRed,
  brightGreen,
  brightYellow,
  brightBlue,
  brightMagenta,
  brightCyan,
  brightWhite,
  // UI Specific Roles
  background,
  foreground,
  selection,
  cursor,
  // Specialized roles
  directory,
  link,
}

class PaletteColors extends ThemeExtension<PaletteColors> {
  final Map<SemanticColor, Color> colors;

  const PaletteColors({required this.colors});

  Color operator [](SemanticColor color) => colors[color]!;

  // Standard Getters
  Color get black => colors[SemanticColor.black]!;
  Color get red => colors[SemanticColor.red]!;
  Color get green => colors[SemanticColor.green]!;
  Color get yellow => colors[SemanticColor.yellow]!;
  Color get blue => colors[SemanticColor.blue]!;
  Color get magenta => colors[SemanticColor.magenta]!;
  Color get cyan => colors[SemanticColor.cyan]!;
  Color get white => colors[SemanticColor.white]!;

  Color get brightBlack => colors[SemanticColor.brightBlack]!;
  Color get brightRed => colors[SemanticColor.brightRed]!;
  Color get brightGreen => colors[SemanticColor.brightGreen]!;
  Color get brightYellow => colors[SemanticColor.brightYellow]!;
  Color get brightBlue => colors[SemanticColor.brightBlue]!;
  Color get brightMagenta => colors[SemanticColor.brightMagenta]!;
  Color get brightCyan => colors[SemanticColor.brightCyan]!;
  Color get brightWhite => colors[SemanticColor.brightWhite]!;

  Color get background => colors[SemanticColor.background]!;
  Color get foreground => colors[SemanticColor.foreground]!;
  Color get selection => colors[SemanticColor.selection]!;
  Color get cursor => colors[SemanticColor.cursor]!;

  @override
  PaletteColors copyWith({Map<SemanticColor, Color>? colors}) {
    return PaletteColors(colors: colors ?? this.colors);
  }

  @override
  PaletteColors lerp(ThemeExtension<PaletteColors>? other, double t) {
    if (other is! PaletteColors) return this;
    final Map<SemanticColor, Color> lerped = {};
    for (final color in SemanticColor.values) {
      if (colors.containsKey(color) && other.colors.containsKey(color)) {
        lerped[color] = Color.lerp(colors[color], other.colors[color], t)!;
      }
    }
    return PaletteColors(colors: lerped);
  }
}

class Catppuccin {
  // Internal Catppuccin raw colors
  static const Color _latteRosewater = Color(0xFFdc8a78);
  static const Color _latteFlamingo = Color(0xFFdd7878);
  static const Color _lattePink = Color(0xFFea76cb);
  static const Color _latteMauve = Color(0xFF8839ef);
  static const Color _latteRed = Color(0xFFd20f39);
  // static const Color _latteMaroon = Color(0xFFe64553);
  static const Color _lattePeach = Color(0xFFfe640b);
  static const Color _latteYellow = Color(0xFFdf8e1d);
  static const Color _latteGreen = Color(0xFF40a02b);
  static const Color _latteTeal = Color(0xFF179287);
  static const Color _latteSky = Color(0xFF04a5e5);
  static const Color _latteSapphire = Color(0xFF209fb5);
  static const Color _latteBlue = Color(0xFF1e66f5);
  // static const Color _latteLavender = Color(0xFF7287fd);
  static const Color _latteText = Color(0xFF4c4f69);
  static const Color _latteSubtext1 = Color(0xFF5c5f77);
  static const Color _latteSubtext0 = Color(0xFF6c6f85);
  // static const Color _latteOverlay2 = Color(0xFF7c7f93);
  // static const Color _latteOverlay1 = Color(0xFF8c8fa1);
  // static const Color _latteOverlay0 = Color(0xFF9ca0b0);
  static const Color _latteSurface2 = Color(0xFFacb0be);
  static const Color _latteSurface1 = Color(0xFFbcc0cc);
  static const Color _latteSurface0 = Color(0xFFccd0da);
  static const Color _latteBase = Color(0xFFeff1f5);
  static const Color _latteMantle = Color(0xFFe6e9ef);
  // static const Color _latteCrust = Color(0xFFdce0e8);

  static const Color _mochaRosewater = Color(0xFFf5e0dc);
  static const Color _mochaFlamingo = Color(0xFFf2cdcd);
  static const Color _mochaPink = Color(0xFFf5c2e7);
  static const Color _mochaMauve = Color(0xFFcba6f7);
  static const Color _mochaRed = Color(0xFFf38ba8);
  // static const Color _mochaMaroon = Color(0xFFeba0ac);
  static const Color _mochaPeach = Color(0xFFfab387);
  static const Color _mochaYellow = Color(0xFFf9e2af);
  static const Color _mochaGreen = Color(0xFFa6e3a1);
  static const Color _mochaTeal = Color(0xFF94e2d5);
  static const Color _mochaSky = Color(0xFF89dceb);
  static const Color _mochaSapphire = Color(0xFF74c7ec);
  static const Color _mochaBlue = Color(0xFF89b4fa);
  // static const Color _mochaLavender = Color(0xFFb4befe);
  static const Color _mochaText = Color(0xFFcdd6f4);
  static const Color _mochaSubtext1 = Color(0xFFbac2de);
  static const Color _mochaSubtext0 = Color(0xFFa6adc8);
  // static const Color _mochaOverlay2 = Color(0xFF9399b2);
  // static const Color _mochaOverlay1 = Color(0xFF7f849c);
  // static const Color _mochaOverlay0 = Color(0xFF6c7086);
  static const Color _mochaSurface2 = Color(0xFF585b70);
  static const Color _mochaSurface1 = Color(0xFF45475a);
  static const Color _mochaSurface0 = Color(0xFF313244);
  static const Color _mochaBase = Color(0xFF1e1e2e);
  static const Color _mochaMantle = Color(0xFF181825);
  // static const Color _mochaCrust = Color(0xFF11111b);

  static const Map<SemanticColor, Color> latte = {
    SemanticColor.background: _latteBase,
    SemanticColor.foreground: _latteText,
    SemanticColor.black: _latteSurface1,
    SemanticColor.red: _latteRed,
    SemanticColor.green: _latteGreen,
    SemanticColor.yellow: _latteYellow,
    SemanticColor.blue: _latteBlue,
    SemanticColor.magenta: _latteMauve,
    SemanticColor.cyan: _latteSky,
    SemanticColor.white: _latteSubtext1,
    SemanticColor.brightBlack: _latteSurface2,
    SemanticColor.brightRed: _latteFlamingo,
    SemanticColor.brightGreen: _latteTeal,
    SemanticColor.brightYellow: _lattePeach,
    SemanticColor.brightBlue: _latteSapphire,
    SemanticColor.brightMagenta: _lattePink,
    SemanticColor.brightCyan: _latteRosewater,
    SemanticColor.brightWhite: _latteSubtext0,
    SemanticColor.selection: _latteSurface0,
    SemanticColor.cursor: _latteRosewater,
    SemanticColor.directory: _latteBlue,
    SemanticColor.link: _latteSky,
  };

  static const Map<SemanticColor, Color> mocha = {
    SemanticColor.background: _mochaBase,
    SemanticColor.foreground: _mochaText,
    SemanticColor.black: _mochaSurface1,
    SemanticColor.red: _mochaRed,
    SemanticColor.green: _mochaGreen,
    SemanticColor.yellow: _mochaYellow,
    SemanticColor.blue: _mochaBlue,
    SemanticColor.magenta: _mochaMauve,
    SemanticColor.cyan: _mochaSky,
    SemanticColor.white: _mochaSubtext1,
    SemanticColor.brightBlack: _mochaSurface2,
    SemanticColor.brightRed: _mochaFlamingo,
    SemanticColor.brightGreen: _mochaTeal,
    SemanticColor.brightYellow: _mochaPeach,
    SemanticColor.brightBlue: _mochaSapphire,
    SemanticColor.brightMagenta: _mochaPink,
    SemanticColor.brightCyan: _mochaRosewater,
    SemanticColor.brightWhite: _mochaSubtext0,
    SemanticColor.selection: _mochaSurface0,
    SemanticColor.cursor: _mochaRosewater,
    SemanticColor.directory: _mochaBlue,
    SemanticColor.link: _mochaSky,
  };

  static ThemeData get latteTheme => _buildTheme(latte, Brightness.light);
  static ThemeData get mochaTheme => _buildTheme(mocha, Brightness.dark);

  static ThemeData _buildTheme(
    Map<SemanticColor, Color> colors,
    Brightness brightness,
  ) {
    final palette = PaletteColors(colors: colors);
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: palette.magenta,
        onPrimary: palette.background,
        secondary: palette.brightMagenta,
        onSecondary: palette.background,
        error: palette.red,
        onError: palette.background,
        surface: palette.background,
        onSurface: palette.foreground,
        outline: palette.brightBlack,
        primaryContainer: palette.blue,
        onPrimaryContainer: palette.foreground,
      ),
      scaffoldBackgroundColor: palette.background,
      appBarTheme: AppBarTheme(
        backgroundColor: brightness == Brightness.light
            ? _latteMantle
            : _mochaMantle,
        foregroundColor: palette.foreground,
        elevation: 0,
      ),
      dividerColor: palette.black,
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return palette.green;
          return null;
        }),
      ),
      extensions: [palette],
    );
  }
}

extension PaletteTheme on ThemeData {
  PaletteColors get palette => extension<PaletteColors>()!;
}

class TagColor {
  final SemanticColor color;
  final int shade; // 0-4 where 4 is the base color

  const TagColor(this.color, [this.shade = 4]);

  String toStorageString() => "${color.name}:$shade";

  static TagColor fromStorageString(String s) {
    final parts = s.split(':');
    if (parts.length != 2) return const TagColor(SemanticColor.blue, 4);
    try {
      return TagColor(
        SemanticColor.values.byName(parts[0]),
        int.parse(parts[1]),
      );
    } catch (e) {
      return const TagColor(SemanticColor.blue, 4);
    }
  }
}

class TagPalette {
  static const List<SemanticColor> baseColors = [
    SemanticColor.red,
    SemanticColor.green,
    SemanticColor.yellow,
    SemanticColor.blue,
    SemanticColor.magenta,
    SemanticColor.cyan,
    SemanticColor.brightRed,
    SemanticColor.brightGreen,
    SemanticColor.brightYellow,
    SemanticColor.brightBlue,
    SemanticColor.brightMagenta,
    SemanticColor.brightCyan,
  ];

  static Color resolveColor(BuildContext context, TagColor tagColor) {
    final palette = Theme.of(context).palette;
    final baseColor = palette[tagColor.color];
    if (tagColor.shade == 4) return baseColor;

    final alpha = (tagColor.shade + 1) * 0.2;
    return baseColor.withValues(alpha: alpha);
  }

  static Color getContrastColor(Color background) {
    return background.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
