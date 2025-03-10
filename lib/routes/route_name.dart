import 'package:flutter/material.dart';
import 'package:hotelbooking/models/hotel_list_data.dart';
import 'package:hotelbooking/modules/bottomTab/bottom_tab_screen.dart';
import 'package:hotelbooking/modules/hotel_booking/filter_screen/filters_screen.dart';
import 'package:hotelbooking/modules/hotel_booking/hotel_home_screen.dart';
import 'package:hotelbooking/modules/hotel_detailes/hotel_detailes.dart';
import 'package:hotelbooking/modules/hotel_detailes/reviews_list_screen.dart';
import 'package:hotelbooking/modules/hotel_detailes/room_booking_screen.dart';
import 'package:hotelbooking/modules/hotel_detailes/search_screen.dart';
import 'package:hotelbooking/modules/login/login_screen.dart';
import 'package:hotelbooking/modules/login/sign_up_Screen.dart';
import 'package:hotelbooking/routes/routes.dart';

class NavigationServices {
  NavigationServices(this.context);

  final BuildContext context;

  Future<dynamic> _pushMaterialPageRoute(
    Widget widget, {
    bool fullscreenDialog = false,
  }) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }

  void gotoSplashScreen() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.splash,
      (Route<dynamic> route) => false,
    );
  }

  void gotoIntroductionScreen() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.introductionScreen,
      (Route<dynamic> route) => false,
    );
  }

  Future<dynamic> gotoLoginScreen() async {
    return await _pushMaterialPageRoute(LoginScreen());
  }

  Future<dynamic> gotoTabScreen() async {
    return await _pushMaterialPageRoute(BottomTabScreen());
  }

  Future<dynamic> gotoSignScreen() async {
    return await _pushMaterialPageRoute(SignUpScreen());
  }

  Future<dynamic> gotoSearchScreen() async {
    return await _pushMaterialPageRoute(SearchScreen());
  }

  Future<dynamic> gotoHotelHomeScreen() async {
    return await _pushMaterialPageRoute(HotelHomeScreen());
  }

  Future<dynamic> gotoFiltersScreen() async {
    return await _pushMaterialPageRoute(FiltersScreen());
  }

  Future<dynamic> gotoRoomBookingScreen(String hotelname) async {
    return await _pushMaterialPageRoute(
      RoomBookingScreen(hotelName: hotelname),
    );
  }

  Future<dynamic> gotoHotelDetailes(HotelListData hotelData) async {
    return await _pushMaterialPageRoute(HotelDetailes(hotelData: hotelData));
  }

  Future<dynamic> gotoReviewsListScreen() async {
    return await _pushMaterialPageRoute(ReviewsListScreen());
  }
}
