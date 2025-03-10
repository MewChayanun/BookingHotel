import 'package:flutter/material.dart';
import 'package:hotelbooking/utils/localfiles.dart';
import 'package:hotelbooking/utils/text_styles.dart';
import 'package:hotelbooking/utils/themes.dart';
import 'package:hotelbooking/language/app_localizations.dart';
import 'package:hotelbooking/providers/theme_provider.dart';
import 'package:hotelbooking/routes/route_name.dart';
import 'package:hotelbooking/widgets/common_button.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool isLoadText = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _loadAppLocalizations(),
    );
    super.initState();
  }

  Future<void> _loadAppLocalizations() async {
    try {
      setState(() {
        isLoadText = true;
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            foregroundDecoration:
                !appTheme.isLightMode
                    ? BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surface.withValues(alpha: 0.4),
                    )
                    : null,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(Localfiles.introduction, fit: BoxFit.cover),
          ),
          Column(
            children: <Widget>[
              Expanded(flex: 1, child: SizedBox()),
              Center(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Theme.of(context).dividerColor,
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    child: Image.asset(Localfiles.appIcon),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Hotel",
                textAlign: TextAlign.left,
                style: TextStyles(
                  context,
                ).getBoldStyle().copyWith(fontSize: 24),
              ),
              SizedBox(height: 8),
              AnimatedOpacity(
                opacity: isLoadText ? 1.0 : 0.0,
                duration: Duration(milliseconds: 420),
                child: Text(
                  AppLocalizations(context).of("best_hotel_deals"),
                  textAlign: TextAlign.left,
                  style: TextStyles(
                    context,
                  ).getRegularStyle().copyWith(color: Colors.black),
                ),
              ),
              Expanded(flex: 4, child: SizedBox()),
              AnimatedOpacity(
                opacity: isLoadText ? 1.0 : 0.0,
                duration: Duration(milliseconds: 680),
                child: CommonButton(
                  padding: const EdgeInsets.only(
                    left: 48,
                    right: 48,
                    bottom: 8,
                    top: 8,
                  ),
                  buttonText: AppLocalizations(context).of("get_started"),
                  onTap: () {
                    NavigationServices(context).gotoIntroductionScreen();
                  },
                ),
              ),
              AnimatedOpacity(
                opacity: isLoadText ? 1.0 : 0.0,
                duration: Duration(milliseconds: 1200),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 24.0 + MediaQuery.of(context).padding.bottom,
                    top: 16,
                  ),
                  child: Text(
                    AppLocalizations(context).of("already_have_account"),
                    textAlign: TextAlign.left,
                    style: TextStyles(context).getDescriptionStyle().copyWith(
                      color: AppTheme.whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
