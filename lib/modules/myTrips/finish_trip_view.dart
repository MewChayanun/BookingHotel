import 'package:flutter/material.dart';
import 'package:hotelbooking/modules/myTrips/hotel_list_view_data.dart';
import 'package:hotelbooking/routes/route_name.dart';
import '../../models/hotel_list_data.dart';

class FinishTripView extends StatefulWidget {
  final AnimationController animationController;

  const FinishTripView({super.key, required this.animationController});

  @override
  FinishTripViewState createState() => FinishTripViewState();
}

class FinishTripViewState extends State<FinishTripView> {
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
      padding: EdgeInsets.only(top: 8, bottom: 16),
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

        return HotelListViewData(
          callback: () {
            NavigationServices(
              context,
            ).gotoRoomBookingScreen(hotelList[index].titleTxt);
          },
          hotelData: hotelList[index],
          animation: animation,
          animationController: widget.animationController,
          isShowDate: (index % 2) != 0,
        );
      },
    );
  }
}
