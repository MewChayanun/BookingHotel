import 'package:flutter/material.dart';
import 'package:hotelbooking/widgets/common_appbar_view.dart';
import '../../models/hotel_list_data.dart';
import 'review_data_view.dart';

class ReviewsListScreen extends StatefulWidget {
  const ReviewsListScreen({super.key});

  @override
  ReviewsListScreenState createState() => ReviewsListScreenState();
}

class ReviewsListScreenState extends State<ReviewsListScreen>
    with TickerProviderStateMixin {
  List<HotelListData> reviewsList = HotelListData.reviewsList;
  late AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CommonAppbarView(
            iconData: Icons.close,
            onBackClick: () {
              Navigator.pop(context);
            },
            titleText: "Review(20)",
          ),

          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                top: 8,
                bottom: MediaQuery.of(context).padding.bottom + 8,
              ),
              itemCount: reviewsList.length,
              itemBuilder: (context, index) {
                var count = reviewsList.length > 10 ? 10 : reviewsList.length;
                var animation = Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: animationController,
                    curve: Interval(
                      (1 / count) * index,
                      1.0,
                      curve: Curves.fastOutSlowIn,
                    ),
                  ),
                );
                animationController.forward();
                return ReviewsView(
                  callback: () {},
                  reviewsList: reviewsList[index],
                  animation: animation,
                  animationController: animationController,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
