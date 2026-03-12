import 'package:flutter/material.dart';

class CatppuccinColors extends ThemeExtension<CatppuccinColors> {
  final Color rosewater;
  final Color flamingo;
  final Color pink;
  final Color mauve;
  final Color red;
  final Color maroon;
  final Color peach;
  final Color yellow;
  final Color green;
  final Color teal;
  final Color sky;
  final Color sapphire;
  final Color blue;
  final Color lavender;
  final Color text;
  final Color subtext1;
  final Color subtext0;
  final Color overlay2;
  final Color overlay1;
  final Color overlay0;
  final Color surface2;
  final Color surface1;
  final Color surface0;
  final Color base;
  final Color mantle;
  final Color crust;

  const CatppuccinColors({
    required this.rosewater,
    required this.flamingo,
    required this.pink,
    required this.mauve,
    required this.red,
    required this.maroon,
    required this.peach,
    required this.yellow,
    required this.green,
    required this.teal,
    required this.sky,
    required this.sapphire,
    required this.blue,
    required this.lavender,
    required this.text,
    required this.subtext1,
    required this.subtext0,
    required this.overlay2,
    required this.overlay1,
    required this.overlay0,
    required this.surface2,
    required this.surface1,
    required this.surface0,
    required this.base,
    required this.mantle,
    required this.crust,
  });

  @override
  CatppuccinColors copyWith({
    Color? rosewater,
    Color? flamingo,
    Color? pink,
    Color? mauve,
    Color? red,
    Color? maroon,
    Color? peach,
    Color? yellow,
    Color? green,
    Color? teal,
    Color? sky,
    Color? sapphire,
    Color? blue,
    Color? lavender,
    Color? text,
    Color? subtext1,
    Color? subtext0,
    Color? overlay2,
    Color? overlay1,
    Color? overlay0,
    Color? surface2,
    Color? surface1,
    Color? surface0,
    Color? base,
    Color? mantle,
    Color? crust,
  }) {
    return CatppuccinColors(
      rosewater: rosewater ?? this.rosewater,
      flamingo: flamingo ?? this.flamingo,
      pink: pink ?? this.pink,
      mauve: mauve ?? this.mauve,
      red: red ?? this.red,
      maroon: maroon ?? this.maroon,
      peach: peach ?? this.peach,
      yellow: yellow ?? this.yellow,
      green: green ?? this.green,
      teal: teal ?? this.teal,
      sky: sky ?? this.sky,
      sapphire: sapphire ?? this.sapphire,
      blue: blue ?? this.blue,
      lavender: lavender ?? this.lavender,
      text: text ?? this.text,
      subtext1: subtext1 ?? this.subtext1,
      subtext0: subtext0 ?? this.subtext0,
      overlay2: overlay2 ?? this.overlay2,
      overlay1: overlay1 ?? this.overlay1,
      overlay0: overlay0 ?? this.overlay0,
      surface2: surface2 ?? this.surface2,
      surface1: surface1 ?? this.surface1,
      surface0: surface0 ?? this.surface0,
      base: base ?? this.base,
      mantle: mantle ?? this.mantle,
      crust: crust ?? this.crust,
    );
  }

  @override
  CatppuccinColors lerp(ThemeExtension<CatppuccinColors>? other, double t) {
    if (other is! CatppuccinColors) return this;
    return CatppuccinColors(
      rosewater: Color.lerp(rosewater, other.rosewater, t)!,
      flamingo: Color.lerp(flamingo, other.flamingo, t)!,
      pink: Color.lerp(pink, other.pink, t)!,
      mauve: Color.lerp(mauve, other.mauve, t)!,
      red: Color.lerp(red, other.red, t)!,
      maroon: Color.lerp(maroon, other.maroon, t)!,
      peach: Color.lerp(peach, other.peach, t)!,
      yellow: Color.lerp(yellow, other.yellow, t)!,
      green: Color.lerp(green, other.green, t)!,
      teal: Color.lerp(teal, other.teal, t)!,
      sky: Color.lerp(sky, other.sky, t)!,
      sapphire: Color.lerp(sapphire, other.sapphire, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      lavender: Color.lerp(lavender, other.lavender, t)!,
      text: Color.lerp(text, other.text, t)!,
      subtext1: Color.lerp(subtext1, other.subtext1, t)!,
      subtext0: Color.lerp(subtext0, other.subtext0, t)!,
      overlay2: Color.lerp(overlay2, other.overlay2, t)!,
      overlay1: Color.lerp(overlay1, other.overlay1, t)!,
      overlay0: Color.lerp(overlay0, other.overlay0, t)!,
      surface2: Color.lerp(surface2, other.surface2, t)!,
      surface1: Color.lerp(surface1, other.surface1, t)!,
      surface0: Color.lerp(surface0, other.surface0, t)!,
      base: Color.lerp(base, other.base, t)!,
      mantle: Color.lerp(mantle, other.mantle, t)!,
      crust: Color.lerp(crust, other.crust, t)!,
    );
  }
}

class Catppuccin {
  static const Color latteRosewater = Color(0xFFdc8a78);
  static const Color latteFlamingo = Color(0xFFdd7878);
  static const Color lattePink = Color(0xFFea76cb);
  static const Color latteMauve = Color(0xFF8839ef);
  static const Color latteRed = Color(0xFFd20f39);
  static const Color latteMaroon = Color(0xFFe64553);
  static const Color lattePeach = Color(0xFFfe640b);
  static const Color latteYellow = Color(0xFFdf8e1d);
  static const Color latteGreen = Color(0xFF40a02b);
  static const Color latteTeal = Color(0xFF179287);
  static const Color latteSky = Color(0xFF04a5e5);
  static const Color latteSapphire = Color(0xFF209fb5);
  static const Color latteBlue = Color(0xFF1e66f5);
  static const Color latteLavender = Color(0xFF7287fd);
  static const Color latteText = Color(0xFF4c4f69);
  static const Color latteSubtext1 = Color(0xFF5c5f77);
  static const Color latteSubtext0 = Color(0xFF6c6f85);
  static const Color latteOverlay2 = Color(0xFF7c7f93);
  static const Color latteOverlay1 = Color(0xFF8c8fa1);
  static const Color latteOverlay0 = Color(0xFF9ca0b0);
  static const Color latteSurface2 = Color(0xFFacb0be);
  static const Color latteSurface1 = Color(0xFFbcc0cc);
  static const Color latteSurface0 = Color(0xFFccd0da);
  static const Color latteBase = Color(0xFFeff1f5);
  static const Color latteMantle = Color(0xFFe6e9ef);
  static const Color latteCrust = Color(0xFFdce0e8);

  static const Color mochaRosewater = Color(0xFFf5e0dc);
  static const Color mochaFlamingo = Color(0xFFf2cdcd);
  static const Color mochaPink = Color(0xFFf5c2e7);
  static const Color mochaMauve = Color(0xFFcba6f7);
  static const Color mochaRed = Color(0xFFf38ba8);
  static const Color mochaMaroon = Color(0xFFeba0ac);
  static const Color mochaPeach = Color(0xFFfab387);
  static const Color mochaYellow = Color(0xFFf9e2af);
  static const Color mochaGreen = Color(0xFFa6e3a1);
  static const Color mochaTeal = Color(0xFF94e2d5);
  static const Color mochaSky = Color(0xFF89dceb);
  static const Color mochaSapphire = Color(0xFF74c7ec);
  static const Color mochaBlue = Color(0xFF89b4fa);
  static const Color mochaLavender = Color(0xFFb4befe);
  static const Color mochaText = Color(0xFFcdd6f4);
  static const Color mochaSubtext1 = Color(0xFFbac2de);
  static const Color mochaSubtext0 = Color(0xFFa6adc8);
  static const Color mochaOverlay2 = Color(0xFF9399b2);
  static const Color mochaOverlay1 = Color(0xFF7f849c);
  static const Color mochaOverlay0 = Color(0xFF6c7086);
  static const Color mochaSurface2 = Color(0xFF585b70);
  static const Color mochaSurface1 = Color(0xFF45475a);
  static const Color mochaSurface0 = Color(0xFF313244);
  static const Color mochaBase = Color(0xFF1e1e2e);
  static const Color mochaMantle = Color(0xFF181825);
  static const Color mochaCrust = Color(0xFF11111b);

  static const latteColors = CatppuccinColors(
    rosewater: latteRosewater,
    flamingo: latteFlamingo,
    pink: lattePink,
    mauve: latteMauve,
    red: latteRed,
    maroon: latteMaroon,
    peach: lattePeach,
    yellow: latteYellow,
    green: latteGreen,
    teal: latteTeal,
    sky: latteSky,
    sapphire: latteSapphire,
    blue: latteBlue,
    lavender: latteLavender,
    text: latteText,
    subtext1: latteSubtext1,
    subtext0: latteSubtext0,
    overlay2: latteOverlay2,
    overlay1: latteOverlay1,
    overlay0: latteOverlay0,
    surface2: latteSurface2,
    surface1: latteSurface1,
    surface0: latteSurface0,
    base: latteBase,
    mantle: latteMantle,
    crust: latteCrust,
  );

  static const mochaColors = CatppuccinColors(
    rosewater: mochaRosewater,
    flamingo: mochaFlamingo,
    pink: mochaPink,
    mauve: mochaMauve,
    red: mochaRed,
    maroon: mochaMaroon,
    peach: mochaPeach,
    yellow: mochaYellow,
    green: mochaGreen,
    teal: mochaTeal,
    sky: mochaSky,
    sapphire: mochaSapphire,
    blue: mochaBlue,
    lavender: mochaLavender,
    text: mochaText,
    subtext1: mochaSubtext1,
    subtext0: mochaSubtext0,
    overlay2: mochaOverlay2,
    overlay1: mochaOverlay1,
    overlay0: mochaOverlay0,
    surface2: mochaSurface2,
    surface1: mochaSurface1,
    surface0: mochaSurface0,
    base: mochaBase,
    mantle: mochaMantle,
    crust: mochaCrust,
  );

  static ThemeData get latte => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: latteColors.mauve,
          onPrimary: latteColors.base,
          secondary: latteColors.pink,
          onSecondary: latteColors.base,
          error: latteColors.red,
          onError: latteColors.base,
          surface: latteColors.base,
          onSurface: latteColors.text,
          outline: latteColors.overlay0,
          primaryContainer: latteColors.lavender,
          onPrimaryContainer: latteColors.text,
        ),
        scaffoldBackgroundColor: latteColors.base,
        appBarTheme: AppBarTheme(
          backgroundColor: latteColors.mantle,
          foregroundColor: latteColors.text,
          elevation: 0,
        ),
        dividerColor: latteColors.surface0,
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return latteColors.green;
            return null;
          }),
        ),
        extensions: [latteColors],
      );

  static ThemeData get mocha => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: mochaColors.mauve,
          onPrimary: mochaColors.base,
          secondary: mochaColors.pink,
          onSecondary: mochaColors.base,
          error: mochaColors.red,
          onError: mochaColors.base,
          surface: mochaColors.base,
          onSurface: mochaColors.text,
          outline: mochaColors.overlay0,
          primaryContainer: mochaColors.lavender,
          onPrimaryContainer: mochaColors.base,
        ),
        scaffoldBackgroundColor: mochaColors.base,
        appBarTheme: AppBarTheme(
          backgroundColor: mochaColors.mantle,
          foregroundColor: mochaColors.text,
          elevation: 0,
        ),
        dividerColor: mochaColors.surface0,
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return mochaColors.green;
            return null;
          }),
        ),
        extensions: [mochaColors],
      );
}

extension CatppuccinTheme on ThemeData {
  CatppuccinColors get catppuccin => extension<CatppuccinColors>()!;
}

class TagPalette {
  static const List<Color> baseColors = [
    Catppuccin.mochaRosewater,
    Catppuccin.mochaFlamingo,
    Catppuccin.mochaPink,
    Catppuccin.mochaMauve,
    Catppuccin.mochaRed,
    Catppuccin.mochaMaroon,
    Catppuccin.mochaPeach,
    Catppuccin.mochaYellow,
    Catppuccin.mochaGreen,
    Catppuccin.mochaTeal,
    Catppuccin.mochaSky,
    Catppuccin.mochaSapphire,
    Catppuccin.mochaBlue,
    Catppuccin.mochaLavender,
  ];

  static List<Color>? getShades(Color baseColor) {
    return [
      baseColor.withValues(alpha: 0.2),
      baseColor.withValues(alpha: 0.4),
      baseColor.withValues(alpha: 0.6),
      baseColor.withValues(alpha: 0.8),
      baseColor,
    ];
  }

  static Color getColor(int? value) {
    if (value == null) return baseColors[3]; // Default Mauve
    return Color(value);
  }

  static Color getContrastColor(Color background) {
    return background.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
