import 'package:flutter/material.dart';
import 'package:hotelbooking/language/app_localizations.dart';
import 'package:hotelbooking/models/hotel_list_data.dart';
import 'package:hotelbooking/utils/helper.dart';
import 'package:hotelbooking/utils/text_styles.dart';
import 'package:hotelbooking/widgets/common_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RoomeBookView extends StatefulWidget {
  final HotelListData roomData;
  final AnimationController animationController;
  final Animation<double> animation;

  const RoomeBookView({
    super.key,
    required this.roomData,
    required this.animationController,
    required this.animation,
  });

  @override
  RoomeBookViewState createState() => RoomeBookViewState();
}

class RoomeBookViewState extends State<RoomeBookView> {
  var pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    List<String> images = widget.roomData.imagePath.split(" ");
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation,
          child: Transform(
            transform: Matrix4.translationValues(
              0.0,
              40 * (1.0 - widget.animation.value),
              0.0,
            ),
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: PageView(
                        controller: pageController,
                        pageSnapping: true,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          for (var image in images)
                            Image.asset(image, fit: BoxFit.cover),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        effect: WormEffect(
                          activeDotColor: Theme.of(context).primaryColor,
                          dotColor: Theme.of(context).colorScheme.surface,
                          dotHeight: 10.0,
                          dotWidth: 10.0,
                          spacing: 5.0,
                        ),
                        onDotClicked: (index) {},
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 16,
                    top: 16,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.roomData.titleTxt,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            style: TextStyles(
                              context,
                            ).getBoldStyle().copyWith(fontSize: 24),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Expanded(child: SizedBox()),
                          SizedBox(
                            height: 38,
                            child: CommonButton(
                              buttonTextWidget: Padding(
                                padding: const EdgeInsets.only(
                                  left: 16.0,
                                  right: 16.0,
                                  top: 4,
                                  bottom: 4,
                                ),
                                child: Text(
                                  AppLocalizations(context).of("book_now"),
                                  textAlign: TextAlign.center,
                                  style: TextStyles(context).getRegularStyle(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "\$${widget.roomData.perNight}",
                            textAlign: TextAlign.left,
                            style: TextStyles(
                              context,
                            ).getBoldStyle().copyWith(fontSize: 22),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0),
                            child: Text(
                              AppLocalizations(context).of("per_night"),
                              style: TextStyles(
                                context,
                              ).getRegularStyle().copyWith(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            Helper.getPeopleandChildren(
                              widget.roomData.roomData!,
                            ),
                            textAlign: TextAlign.left,
                            style: TextStyles(context).getDescriptionStyle(),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 4),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations(
                                      context,
                                    ).of("more_details"),
                                    style: TextStyles(context).getBoldStyle(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(height: 1),
              ],
            ),
          ),
        );
      },
    );
  }
}
