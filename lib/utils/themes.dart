import 'package:flutter/material.dart';
import 'package:hotelbooking/utils/enum.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotelbooking/providers/theme_provider.dart';
import 'package:hotelbooking/hotel_app.dart';
import 'package:provider/provider.dart';

class AppTheme {
  static bool get isLightMode {
    return applicationcontext == null
        ? true
        : applicationcontext!.read<ThemeProvider>().isLightMode;
  }

  static Color get primaryColor {
    ColorType colorTypeData =
        applicationcontext == null
            ? ColorType.verdigris
            : applicationcontext!.read<ThemeProvider>().colorType;

    return getColor(colorTypeData);
  }

  static Color get scaffoldBackgroundColor =>
      isLightMode ? const Color(0xFFF7F7F7) : const Color(0xFF1A1A1A);

  static Color get redErrorColor =>
      isLightMode ? const Color(0xFFAC0000) : const Color(0xFFAC0000);

  static Color get backgroundColor =>
      isLightMode ? const Color(0xFFFFFFFF) : const Color(0xFF2C2C2C);

  static Color get primaryTextColor =>
      isLightMode ? const Color(0xFF262626) : const Color(0xFFFFFFFF);

  static Color get secondaryTextColor =>
      isLightMode ? const Color(0xFFADADAD) : const Color(0xFF6D6D6D);

  static Color get whiteColor => const Color(0xFFFFFFFF);
  static Color get backColor => const Color(0xFF262626);

  static Color get fontColor =>
      isLightMode ? const Color(0xFF1A1A1A) : const Color(0xFFF7F7F7);

  static ThemeData get getThemeData =>
      isLightMode ? _buildLightTheme() : _buildDarkTheme();

  static TextTheme _buildTextTheme(TextTheme base) {
    FontFamilyType fontType =
        applicationcontext == null
            ? FontFamilyType.workSans
            : applicationcontext!.read<ThemeProvider>().fontType;
    return base.copyWith(
      displayLarge: getTextStyle(fontType, base.displayLarge!),
      displayMedium: getTextStyle(fontType, base.displayMedium!),
      displaySmall: getTextStyle(fontType, base.displaySmall!),
      headlineLarge: getTextStyle(fontType, base.headlineLarge!),
      headlineMedium: getTextStyle(fontType, base.headlineMedium!),
      headlineSmall: getTextStyle(
        fontType,
        base.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
      ),
      labelLarge: getTextStyle(fontType, base.labelLarge!),
      bodySmall: getTextStyle(fontType, base.bodySmall!),
      bodyLarge: getTextStyle(fontType, base.bodyLarge!),
      bodyMedium: getTextStyle(fontType, base.bodyMedium!),
      titleLarge: getTextStyle(
        fontType,
        base.titleLarge!.copyWith(fontWeight: FontWeight.bold),
      ),
      titleMedium: getTextStyle(fontType, base.titleMedium!),
      labelSmall: getTextStyle(fontType, base.labelSmall!),
    );
  }

  static Color getColor(ColorType colorData) {
    switch (colorData) {
      case ColorType.verdigris:
        return isLightMode ? const Color(0xFF4FBE9F) : const Color(0xFF4FBE9F);
      case ColorType.malibu:
        return isLightMode ? const Color(0xFF5DCAEC) : const Color(0xFF5DCAEC);
      case ColorType.darkSkyBlue:
        return isLightMode ? const Color(0xFF458CEA) : const Color(0xFF458CEA);
      case ColorType.bilobaFlower:
        return isLightMode ? const Color(0xFFff5f5f) : const Color(0xFFff5f5f);
    }
  }

  static TextStyle getTextStyle(
    FontFamilyType fontFamilyType,
    TextStyle textStyle,
  ) {
    switch (fontFamilyType) {
      case FontFamilyType.montserrat:
        return GoogleFonts.montserrat(textStyle: textStyle);
      case FontFamilyType.workSans:
        return GoogleFonts.workSans(textStyle: textStyle);
      case FontFamilyType.varela:
        return GoogleFonts.varela(textStyle: textStyle);
      case FontFamilyType.satisfy:
        return GoogleFonts.satisfy(textStyle: textStyle);
      case FontFamilyType.dancingScript:
        return GoogleFonts.dancingScript(textStyle: textStyle);
      case FontFamilyType.kaushanScript:
        return GoogleFonts.kaushanScript(textStyle: textStyle);
    }
  }

  static ThemeData _buildLightTheme() {
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: primaryColor,
    );
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      canvasColor: scaffoldBackgroundColor,
      buttonTheme: _buttonThemeData(colorScheme),
      dialogTheme: _dialogTheme(),
      cardTheme: _cardTheme(),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.textTheme),
      platform: TargetPlatform.iOS,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: colorScheme.copyWith(surface: backgroundColor),
    );
  }

  static ThemeData _buildDarkTheme() {
    final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
      primary: primaryColor,
      secondary: primaryColor,
    );
    final ThemeData base = ThemeData.dark();

    return base.copyWith(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      canvasColor: scaffoldBackgroundColor,
      buttonTheme: _buttonThemeData(colorScheme),
      dialogTheme: _dialogTheme(),
      cardTheme: _cardTheme(),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.textTheme),
      platform: TargetPlatform.iOS,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: colorScheme.copyWith(surface: backgroundColor),
    );
  }

  static ButtonThemeData _buttonThemeData(ColorScheme colorScheme) {
    return ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    );
  }

  static DialogTheme _dialogTheme() {
    return DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 0,
      backgroundColor: backgroundColor,
    );
  }

  static CardTheme _cardTheme() {
    return CardTheme(
      clipBehavior: Clip.antiAlias,
      color: backgroundColor,
      shadowColor: secondaryTextColor.withValues(
        red: secondaryTextColor.r.toDouble(),
        green: secondaryTextColor.g.toDouble(),
        blue: secondaryTextColor.b.toDouble(),
        alpha: 0.2,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 8,
      margin: const EdgeInsets.all(0),
    );
  }

  static get mapCardDecoration => BoxDecoration(
    color: AppTheme.scaffoldBackgroundColor,
    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Theme.of(applicationcontext!).dividerColor,
        offset: const Offset(4, 4),
        blurRadius: 8.0,
      ),
    ],
  );

  static get buttonDecoration => BoxDecoration(
    color: AppTheme.primaryColor,
    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Theme.of(applicationcontext!).dividerColor,
        blurRadius: 8,
        offset: const Offset(4, 4),
      ),
    ],
  );

  static get searchBarDecoration => BoxDecoration(
    color: AppTheme.scaffoldBackgroundColor,
    borderRadius: const BorderRadius.all(Radius.circular(38)),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Theme.of(applicationcontext!).dividerColor,
        blurRadius: 8,
      ),
    ],
  );

  static get boxDecoration => BoxDecoration(
    color: AppTheme.scaffoldBackgroundColor,
    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Theme.of(applicationcontext!).dividerColor,
        blurRadius: 8,
      ),
    ],
  );
}

enum ThemeModeType { system, dark, light }
