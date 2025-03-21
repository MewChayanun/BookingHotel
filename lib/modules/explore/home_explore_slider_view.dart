import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hotelbooking/language/app_localizations.dart';
import 'package:hotelbooking/modules/splash/components/page_pop_view.dart';
import 'package:hotelbooking/providers/theme_provider.dart';
import 'package:hotelbooking/utils/enum.dart';
import 'package:hotelbooking/utils/localfiles.dart';
import 'package:hotelbooking/utils/text_styles.dart';
import 'package:hotelbooking/utils/themes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider/provider.dart';

class HomeExploreSliderView extends StatefulWidget {
  final double opValue;
  final VoidCallback click;

  const HomeExploreSliderView({
    super.key,
    this.opValue = 0.0,
    required this.click,
  });
  @override
  HomeExploreSliderViewState createState() => HomeExploreSliderViewState();
}

class HomeExploreSliderViewState extends State<HomeExploreSliderView> {
  var pageController = PageController(initialPage: 0);
  List<PageViewData> pageViewModelData = [];

  late Timer sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
    pageViewModelData.add(
      PageViewData(
        titleText: 'cape Town',
        subText: 'five_star',
        assetsImage: Localfiles.explore_2,
      ),
    );
    pageViewModelData.add(
      PageViewData(
        titleText: 'find_best_deals',
        subText: 'five_star',
        assetsImage: Localfiles.explore_1,
      ),
    );
    pageViewModelData.add(
      PageViewData(
        titleText: 'find_best_deals',
        subText: 'five_star',
        assetsImage: Localfiles.explore_3,
      ),
    );

    sliderTimer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (mounted) {
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
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    sliderTimer.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: <Widget>[
          PageView(
            controller: pageController,
            pageSnapping: true,
            onPageChanged: (index) {
              currentShowIndex = index;
            },
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              PagePopup(
                imageData: pageViewModelData[0],
                opValue: widget.opValue,
              ),
              PagePopup(
                imageData: pageViewModelData[1],
                opValue: widget.opValue,
              ),
              PagePopup(
                imageData: pageViewModelData[2],
                opValue: widget.opValue,
              ),
            ],
          ),
          Positioned(
            bottom: 32,
            right:
                context.read<ThemeProvider>().languageType == LanguageType.en
                    ? null
                    : 32,
            left:
                context.read<ThemeProvider>().languageType == LanguageType.en
                    ? 32
                    : null,
            child: SmoothPageIndicator(
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
          ),
        ],
      ),
    );
  }
}

class PagePopup extends StatelessWidget {
  final PageViewData imageData;
  final double opValue;

  const PagePopup({super.key, required this.imageData, this.opValue = 0.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          height: (MediaQuery.of(context).size.width * 1.3),
          width: MediaQuery.of(context).size.width,
          child: Image.asset(imageData.assetsImage, fit: BoxFit.cover),
        ),
        Positioned(
          bottom: 80,
          left: 24,
          right: 24,
          child: Opacity(
            opacity: opValue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppLocalizations(context).of(imageData.titleText),
                  textAlign: TextAlign.left,
                  style: TextStyles(
                    context,
                  ).getTitleStyle().copyWith(color: AppTheme.whiteColor),
                ),
                SizedBox(height: 8),
                Text(
                  AppLocalizations(context).of(imageData.subText),
                  textAlign: TextAlign.left,
                  style: TextStyles(context).getRegularStyle().copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.whiteColor,
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
