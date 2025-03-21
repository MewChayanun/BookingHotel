import 'package:flutter/material.dart';

class RangeSliderView extends StatefulWidget {
  final Function(RangeValues) onChnageRangeValues;
  final RangeValues values;

  const RangeSliderView({
    super.key,
    required this.values,
    required this.onChnageRangeValues,
  });
  @override
  RangeSliderViewState createState() => RangeSliderViewState();
}

class RangeSliderViewState extends State<RangeSliderView> {
  late RangeValues _values;

  @override
  void initState() {
    _values = widget.values;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(flex: _values.start.round(), child: SizedBox()),
                SizedBox(
                  width: 54,
                  child: Text(
                    "\$${_values.start.round()}",
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(flex: 1000 - _values.start.round(), child: SizedBox()),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(flex: _values.end.round(), child: SizedBox()),
                SizedBox(
                  width: 54,
                  child: Text(
                    "\$${_values.end.round()}",
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(flex: 1000 - _values.end.round(), child: SizedBox()),
              ],
            ),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            //   rangeThumbShape: CustomRangeThumbShape(),
          ),
          child: RangeSlider(
            values: _values,
            min: 10.0,
            max: 1000.0,
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Colors.grey.withAlpha((0.4 * 255).toInt()),
            divisions: 1000,
            onChanged: (RangeValues values) {
              try {
                setState(() {
                  _values = values;
                });
                widget.onChnageRangeValues(_values);
              } catch (e) {}
            },
          ),
        ),
      ],
    );
  }
}
