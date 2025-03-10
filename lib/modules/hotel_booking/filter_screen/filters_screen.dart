import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelbooking/language/app_localizations.dart';
import 'package:hotelbooking/models/popular_filter_list.dart';
import 'package:hotelbooking/utils/themes.dart';
import 'package:hotelbooking/widgets/common_appbar_view.dart';
import 'package:hotelbooking/widgets/common_button.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  FiltersScreenState createState() => FiltersScreenState();
}

class FiltersScreenState extends State<FiltersScreen> {
  List<PopularFilterListData> popularFilterListData =
      PopularFilterListData.popularFList;
  List<PopularFilterListData> accomodationListData =
      PopularFilterListData.accomodationList;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.scaffoldBackgroundColor,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonAppbarView(
              iconData: Icons.close,
              onBackClick: () {
                Navigator.pop(context);
              },
              titleText: AppLocalizations(context).of("filtter"),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: <Widget>[
                      popularFilter(),
                      Divider(height: 1),
                      allAccommodationUI(),
                    ],
                  ),
                ),
              ),
            ),
            Divider(height: 1),
            Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16 + MediaQuery.of(context).padding.bottom,
                top: 8,
              ),
              child: CommonButton(
                buttonText: AppLocalizations(context).of("Apply_text"),
                onTap: () {
                  Navigator.pop(context, true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget allAccommodationUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            AppLocalizations(context).of("type of accommodation"),
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: getAccomodationListUI()),
        ),
      ],
    );
  }

  List<Widget> getAccomodationListUI() {
    return accomodationListData.map((data) {
      return SwitchListTile(
        title: Text(AppLocalizations(context).of(data.titleTxt)),
        value: data.isSelected,
        onChanged: (value) {
          setState(() {
            data.isSelected = value;
          });
        },
      );
    }).toList();
  }

  Widget popularFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            AppLocalizations(context).of("popular filter"),
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: getPList()),
        ),
      ],
    );
  }

  List<Widget> getPList() {
    return popularFilterListData.map((data) {
      return CheckboxListTile(
        title: Text(AppLocalizations(context).of(data.titleTxt)),
        value: data.isSelected,
        onChanged: (value) {
          setState(() {
            data.isSelected = value ?? false;
          });
        },
      );
    }).toList();
  }
}
