import 'package:flutter/material.dart';
import 'package:hotelbooking/language/app_localizations.dart';
import 'package:hotelbooking/modules/bottomTab/components/tab_button_ui.dart';
import 'package:hotelbooking/modules/explore/home_explore_screen.dart';
import 'package:hotelbooking/modules/myTrips/my_trips_screen.dart';
import 'package:hotelbooking/providers/theme_provider.dart';
import 'package:hotelbooking/utils/themes.dart';
import 'package:hotelbooking/widgets/common_card.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomTabScreen extends StatefulWidget {
  const BottomTabScreen({super.key});

  @override
  State<BottomTabScreen> createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  BottomBarType bottomBarType = BottomBarType.explore;
  bool isFirstTime = true;
  Widget indexView = Container();
  @override
  void initState() {
    animationController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    indexView = Container();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startLoadingScreen();
    });
    super.initState();
  }

  Future startLoadingScreen() async {
    await Future.delayed(const Duration(milliseconds: 480));
    setState(() {
      isFirstTime = false;
      indexView = HomeExploreScreen(animationController: animationController);
      animationController.forward();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder:
          (_, provider, child) => SizedBox(
            child: Scaffold(
              bottomNavigationBar: SizedBox(
                height: 60 + MediaQuery.of(context).padding.bottom,
                child: getBottomBarUI(bottomBarType),
              ),
              body:
                  isFirstTime
                      ? Center(child: CircularProgressIndicator(strokeWidth: 2))
                      : indexView,
            ),
          ),
    );
  }

  getBottomBarUI(BottomBarType bottomBarType) {
    return CommonCard(
      color: AppTheme.backgroundColor,
      radius: 0,
      child: Column(
        children: [
          Row(
            children: [
              TabButtonUI(
                icon: Icons.search,
                isSelected: bottomBarType == BottomBarType.explore,
                text: AppLocalizations(context).of("explore"),
                onTap: () {
                  tabClick(BottomBarType.explore);
                },
              ),
              TabButtonUI(
                icon: FontAwesomeIcons.heart,
                isSelected: bottomBarType == BottomBarType.trips,
                text: AppLocalizations(context).of("trips"),
                onTap: () {
                  tabClick(BottomBarType.trips);
                },
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  void tabClick(BottomBarType tabType) {
    if (tabType != bottomBarType) {
      bottomBarType = tabType;
      animationController.reverse().then(
        (value) => {
          if (tabType == BottomBarType.explore)
            {
              setState(() {
                indexView = HomeExploreScreen(
                  animationController: animationController,
                );
              }),
            }
          else if (tabType == BottomBarType.trips)
            {
              setState(() {
                indexView = MyTripsScreen(
                  animationController: animationController,
                );
              }),
            },
        },
      );
    }
  }
}

enum BottomBarType { explore, trips }
