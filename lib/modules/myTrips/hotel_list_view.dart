import 'package:flutter/material.dart';
import 'package:hotelbooking/language/app_localizations.dart';
import 'package:hotelbooking/models/hotel_list_data.dart';
import 'package:hotelbooking/providers/theme_provider.dart';
import 'package:hotelbooking/utils/enum.dart';
import 'package:hotelbooking/utils/helper.dart';
import 'package:hotelbooking/utils/text_styles.dart';
import 'package:hotelbooking/utils/themes.dart';
import 'package:hotelbooking/widgets/common_card.dart';
import 'package:hotelbooking/widgets/list_cell_animation_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HotelListView extends StatelessWidget {
  final bool isShowDate;
  final VoidCallback callback;
  final HotelListData hotelData;
  final AnimationController animationController;
  final Animation<double> animation;

  const HotelListView({
    super.key,
    required this.hotelData,
    required this.animationController,
    required this.animation,
    required this.callback,
    this.isShowDate = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListCellAnimationView(
      animation: animation,
      animationController: animationController,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
        child: Column(
          children: <Widget>[
            isShowDate
                ? Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${Helper.getDateText(hotelData.date!)}, ',
                        style: TextStyles(
                          context,
                        ).getRegularStyle().copyWith(fontSize: 14),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          Helper.getRoomText(hotelData.roomData!),
                          style: TextStyles(
                            context,
                          ).getRegularStyle().copyWith(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                )
                : SizedBox(),
            CommonCard(
              color: AppTheme.backgroundColor,
              radius: 16,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 2,
                          child: Image.asset(
                            hotelData.imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  top: 8,
                                  bottom: 8,
                                  right: 8,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      hotelData.titleTxt,
                                      textAlign: TextAlign.left,
                                      style: TextStyles(
                                        context,
                                      ).getBoldStyle().copyWith(fontSize: 22),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          hotelData.subTxt,
                                          style:
                                              TextStyles(
                                                context,
                                              ).getDescriptionStyle(),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(
                                          FontAwesomeIcons.locationDot,
                                          size: 12,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        Text(
                                          hotelData.dist.toStringAsFixed(1),
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              TextStyles(
                                                context,
                                              ).getDescriptionStyle(),
                                        ),
                                        Expanded(
                                          child: Text(
                                            AppLocalizations(
                                              context,
                                            ).of("km_to_city"),
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                TextStyles(
                                                  context,
                                                ).getDescriptionStyle(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Row(
                                        children: <Widget>[
                                          Helper.ratingStar(),
                                          Text(
                                            " ${hotelData.reviews}",
                                            style:
                                                TextStyles(
                                                  context,
                                                ).getDescriptionStyle(),
                                          ),
                                          Text(
                                            AppLocalizations(
                                              context,
                                            ).of("reviews"),
                                            style:
                                                TextStyles(
                                                  context,
                                                ).getDescriptionStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 16,
                                top: 8,
                                left: 16,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    "\$${hotelData.perNight}",
                                    textAlign: TextAlign.left,
                                    style: TextStyles(
                                      context,
                                    ).getBoldStyle().copyWith(fontSize: 22),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top:
                                          context
                                                      .read<ThemeProvider>()
                                                      .languageType ==
                                                  LanguageType.en
                                              ? 2.0
                                              : 0.0,
                                    ),
                                    child: Text(
                                      AppLocalizations(context).of("per_night"),
                                      style:
                                          TextStyles(
                                            context,
                                          ).getDescriptionStyle(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      bottom: 0,
                      left: 0,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Theme.of(
                            context,
                          ).primaryColor.withAlpha((0.1 * 255).toInt()),
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          onTap: () {
                            try {
                              callback();
                            } catch (e) {}
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          shape: BoxShape.circle,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.all(
                              Radius.circular(32.0),
                            ),
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.favorite_border,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
