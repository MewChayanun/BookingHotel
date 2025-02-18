import 'package:flutter/material.dart';
import 'package:hotelbooking/utils/shared_preferences_keys.dart';
import 'package:hotelbooking/utils/themes.dart';
import 'package:hotelbooking/utils/enum.dart';
import 'package:hotelbooking/motel_app.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider({required ThemeData state}) : super();

  bool _isLightMode = true;
  ThemeData _themeData = AppTheme.getThemeData;
  final ThemeModeType _themeModeType = ThemeModeType.system;
  ThemeData get themeData => _themeData;
  bool get isLightMode => _isLightMode;
  ThemeModeType get themeModeType => _themeModeType;
  FontFamilyType get fontType => _fontType;
  FontFamilyType _fontType = FontFamilyType.workSans;
  ColorType get colorType => _colorType;
  ColorType _colorType = ColorType.verdigris;
  LanguageType get languageType => _languageType;
  LanguageType _languageType = LanguageType.en;

  updateThemeMode(ThemeModeType themeModeType) async {
    await SharedPreferencesKeys().setThemeMode(themeModeType);
    final systembrightness =
        MediaQuery.of(applicationcontext!).platformBrightness;
    checkAndSetThemeMode(themeModeType == ThemeModeType.light
        ? Brightness.light
        : themeModeType == ThemeModeType.dark
            ? Brightness.dark
            : systembrightness);
  }

  void checkAndSetThemeMode(Brightness systemBrightness) async {
    bool isLightTheme = _isLightMode;

    final themeMode = await SharedPreferencesKeys().getThemeMode();
    if (themeMode == ThemeModeType.system) {
      isLightTheme = systemBrightness == Brightness.light;
    } else if (themeMode == ThemeModeType.dark) {
      isLightTheme = false;
    } else {
      isLightTheme = true;
    }

    if (_isLightMode != isLightTheme) {
      _isLightMode = isLightTheme;
      _themeData = AppTheme.getThemeData;
      notifyListeners();
    }
  }

  void checkAndSetFontType() async {
    final fontType = await SharedPreferencesKeys().getFontType();
    if (fontType != _fontType) {
      _fontType = fontType;
      _themeData = AppTheme.getThemeData;
      notifyListeners();
    }
  }

  void updateFontType(FontFamilyType fontType) async {
    await SharedPreferencesKeys().setFontType(fontType);
    _fontType = fontType;
    _themeData = AppTheme.getThemeData;
    notifyListeners();
  }

  void updateColorType(ColorType colorType) async {
    await SharedPreferencesKeys().setColorType(colorType);
    _colorType = colorType;
    _themeData = AppTheme.getThemeData;
    notifyListeners();
  }

  void checkAndSetColorType() async {
    final colorTypeData = await SharedPreferencesKeys().getColorType();
    if (colorTypeData != colorType) {
      _colorType = colorTypeData;
      _themeData = AppTheme.getThemeData;
      notifyListeners();
    }
  }

  void updateLanguage(LanguageType language) async {
    await SharedPreferencesKeys().setLanguageType(language);
    _languageType = language;
    _themeData = AppTheme.getThemeData;
    notifyListeners();
  }

  void checkAndSetLanguage() async {
    final languageTypeData = await SharedPreferencesKeys().getLanguageType();
    if (languageTypeData != languageType) {
      _languageType = languageTypeData;
      _themeData = AppTheme.getThemeData;
      notifyListeners();
    }
  }
}
