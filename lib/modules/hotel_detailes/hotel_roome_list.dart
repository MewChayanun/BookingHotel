import 'package:flutter/material.dart';
import 'package:hotelbooking/utils/localfiles.dart';
import 'package:hotelbooking/utils/themes.dart';
import 'package:hotelbooking/widgets/common_card.dart';

class HotelRoomeList extends StatefulWidget {
  const HotelRoomeList({super.key});

  @override
  HotelRoomeListState createState() => HotelRoomeListState();
}

class HotelRoomeListState extends State<HotelRoomeList> {
  List<String> photosList = [
    Localfiles.hotelroom_1,
    Localfiles.hotelroom_2,
    Localfiles.hotelroom_3,
    Localfiles.hotelroom_4,
    Localfiles.hotelroom_5,
    Localfiles.hotelroom_6,
    Localfiles.hotelroom_7,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 0, bottom: 8, right: 16, left: 16),
        itemCount: photosList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonCard(
              color: AppTheme.backgroundColor,
              radius: 8,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(photosList[index], fit: BoxFit.cover),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
