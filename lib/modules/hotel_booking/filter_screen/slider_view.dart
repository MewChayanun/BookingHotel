import 'package:flutter/material.dart';
import 'package:hotelbooking/language/app_localizations.dart';

class SliderView extends StatefulWidget {
  final Function(double) onChnagedistValue;
  final double distValue;

  const SliderView({
    super.key,
    required this.onChnagedistValue,
    required this.distValue,
  });
  @override
  SliderViewState createState() => SliderViewState();
}

class SliderViewState extends State<SliderView> {
  double distValue = 50.0;

  @override
  void initState() {
    distValue = widget.distValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(flex: distValue.round(), child: SizedBox()),
            SizedBox(
              width: 170,
              child: Row(
                children: [
                  Text(
                    AppLocalizations(context).of("Less_than"),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                    child: Text(
                      (distValue / 10).toStringAsFixed(1),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    AppLocalizations(context).of("km_text"),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(flex: 100 - distValue.round(), child: SizedBox()),
          ],
        ),
        Slider(
          onChanged: (value) {
            setState(() {
              distValue = value;
            });
            try {
              widget.onChnagedistValue(distValue);
            } catch (e) {}
          },
          min: 0.0,
          max: 100.0,
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: Colors.grey.withAlpha((0.4 * 255).toDouble() as int),
          value: distValue,
        ),
      ],
    );
  }
}
