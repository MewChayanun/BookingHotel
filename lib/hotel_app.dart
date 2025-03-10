import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotelbooking/common/common.dart';
import 'package:hotelbooking/language/app_localizations.dart';
import 'package:hotelbooking/providers/theme_provider.dart';
import 'package:hotelbooking/utils/enum.dart';
import 'package:hotelbooking/modules/splash/introduction_screen.dart';
import 'package:hotelbooking/modules/splash/splash_screen.dart';
import 'package:hotelbooking/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

BuildContext? applicationcontext;

class HotelApp extends StatefulWidget {
  const HotelApp({super.key});

  @override
  HotelAppState createState() => HotelAppState();
}

class HotelAppState extends State<HotelApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, provider, child) {
        applicationcontext = context;

        final ThemeData theme = provider.themeData;
        return MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('th')],
          navigatorKey: navigatorKey,
          title: 'Hotel',
          debugShowCheckedModeBanner: false,
          theme: theme,
          routes: _buildRoutes(),
          builder: (BuildContext context, Widget? child) {
            _setFirstTimeSomeData(context, theme);
            double screenWidth = MediaQuery.of(context).size.width;
            double textScaleFactor =
                screenWidth > 360 ? 1.0 : (screenWidth >= 340 ? 0.9 : 0.8);

            return Directionality(
              textDirection:
                  context.read<ThemeProvider>().languageType == LanguageType.en
                      ? TextDirection.rtl
                      : TextDirection.ltr,
              child: Builder(
                builder: (BuildContext context) {
                  return MediaQuery(
                    data: MediaQuery.of(
                      context,
                    ).copyWith(textScaler: TextScaler.linear(textScaleFactor)),
                    child: child ?? const SizedBox(),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  void _setFirstTimeSomeData(BuildContext context, ThemeData theme) {
    applicationcontext = context;
    _setStatusBarNavigationBarTheme(theme);
    context.read<ThemeProvider>().checkAndSetThemeMode(
      MediaQuery.of(context).platformBrightness,
    );
    context.read<ThemeProvider>().checkAndSetColorType();
    context.read<ThemeProvider>().checkAndSetFontType();
    context.read<ThemeProvider>().checkAndSetLanguage();
  }

  void _setStatusBarNavigationBarTheme(ThemeData themeData) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            themeData.brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
        statusBarBrightness: themeData.brightness,
        systemNavigationBarColor: themeData.colorScheme.surface,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness:
            themeData.brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
      ),
    );
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      RoutesName.splash: (BuildContext context) => SplashScreen(),
      RoutesName.introductionScreen:
          (BuildContext context) => IntroductionScreen(),
    };
  }
}
