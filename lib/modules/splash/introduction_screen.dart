import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hotelbooking/routes/route_name.dart';
import 'package:hotelbooking/utils/localfiles.dart';
import 'package:hotelbooking/utils/themes.dart';
import 'package:hotelbooking/language/app_localizations.dart';
import 'package:hotelbooking/modules/splash/components/page_pop_view.dart';
import 'package:hotelbooking/widgets/common_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  IntroductionScreenState createState() => IntroductionScreenState();
}

class IntroductionScreenState extends State<IntroductionScreen> {
  var pageController = PageController(initialPage: 0);
  List<PageViewData> pageViewModelData = [];

  late Timer sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
    pageViewModelData.add(
      PageViewData(
        titleText: 'plan_your_trips',
        subText: 'book_one_of_your',
        assetsImage: Localfiles.introduction1,
      ),
    );

    pageViewModelData.add(
      PageViewData(
        titleText: 'find_best_deals',
        subText: 'find_deals_for_any',
        assetsImage: Localfiles.introduction2,
      ),
    );

    pageViewModelData.add(
      PageViewData(
        titleText: 'best_travelling_all_time',
        subText: 'find_deals_for_any',
        assetsImage: Localfiles.introduction3,
      ),
    );

    sliderTimer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (currentShowIndex == 0) {
        pageController.animateTo(
          MediaQuery.of(context).size.width,
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
        );
      } else if (currentShowIndex == 1) {
        pageController.animateTo(
          MediaQuery.of(context).size.width * 2,
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
        );
      } else if (currentShowIndex == 2) {
        pageController.animateTo(
          0,
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    sliderTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).padding.top),
          Expanded(
            child: PageView(
              controller: pageController,
              pageSnapping: true,
              onPageChanged: (index) {
                currentShowIndex = index;
              },
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                PagePopup(imageData: pageViewModelData[0]),
                PagePopup(imageData: pageViewModelData[1]),
                PagePopup(imageData: pageViewModelData[2]),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: pageController,
            count: 3,
            effect: WormEffect(
              activeDotColor: Theme.of(context).primaryColor,
              dotColor: Theme.of(context).dividerColor,
              dotHeight: 10.0,
              dotWidth: 10.0,
              spacing: 5.0,
            ),
            onDotClicked: (index) {},
          ),
          CommonButton(
            padding: const EdgeInsets.only(
              left: 48,
              right: 48,
              bottom: 8,
              top: 8,
            ),
            buttonText: AppLocalizations(context).of("login"),
            onTap: () {
              NavigationServices(context).gotoLoginScreen();
              Scaffold();
            },
          ),
          CommonButton(
            padding: const EdgeInsets.only(
              left: 48,
              right: 48,
              bottom: 8,
              top: 8,
            ),
            backgroundColor: AppTheme.backgroundColor,
            textColor: AppTheme.primaryTextColor,
            buttonText: AppLocalizations(context).of("create_account"),
            onTap: () {
              NavigationServices(context).gotoSignScreen();
            },
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
