import 'package:flutter/material.dart';
import 'package:hotelbooking/modules/explore/hotel_list_view_page.dart';
import 'package:hotelbooking/routes/route_name.dart';
import '../../models/hotel_list_data.dart';

class FavoritesListView extends StatefulWidget {
  final AnimationController animationController;

  const FavoritesListView({super.key, required this.animationController});
  @override
  FavoritesListViewState createState() => FavoritesListViewState();
}

class FavoritesListViewState extends State<FavoritesListView> {
  var hotelList = HotelListData.hotelList;

  @override
  void initState() {
    widget.animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: hotelList.length,
      padding: EdgeInsets.only(top: 8, bottom: 8),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        var count = hotelList.length > 10 ? 10 : hotelList.length;
        var animation = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(
              (1 / count) * index,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        );
        widget.animationController.forward();
        return HotelListViewPage(
          callback: () {
            NavigationServices(
              context,
            ).gotoRoomBookingScreen(hotelList[index].titleTxt);
          },
          hotelData: hotelList[index],
          animation: animation,
          animationController: widget.animationController,
        );
      },
    );
  }
}
