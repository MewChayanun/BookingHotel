import 'package:flutter/material.dart';
import 'package:hotelbooking/modules/explore/category_view.dart';
import 'package:hotelbooking/widgets/bottom_top_move_animation_view.dart';
import '../../models/hotel_list_data.dart';

class PopularListView extends StatefulWidget {
  final Function(int) callBack;
  final AnimationController animationController;
  const PopularListView({
    super.key,
    required this.callBack,
    required this.animationController,
  });
  @override
  PopularListViewState createState() => PopularListViewState();
}

class PopularListViewState extends State<PopularListView>
    with TickerProviderStateMixin {
  var popularList = HotelListData.popularList;
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    super.initState();
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomTopMoveAnimationView(
      animationController: animationController!,
      child: SizedBox(
        height: 180,
        width: double.infinity,
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SizedBox();
            } else {
              return ListView.builder(
                padding: const EdgeInsets.only(
                  top: 0,
                  bottom: 0,
                  right: 24,
                  left: 8,
                ),
                itemCount: popularList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var count = popularList.length > 10 ? 10 : popularList.length;
                  var animation = Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController!,
                      curve: Interval(
                        (1 / count) * index,
                        1.0,
                        curve: Curves.fastOutSlowIn,
                      ),
                    ),
                  );
                  animationController?.forward();
                  return CategoryView(
                    popularList: popularList[index],
                    animation: animation,
                    animationController: animationController!,
                    callback: () {
                      widget.callBack(index);
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
