import 'package:mplanner/healthCal/widget_utils.dart' show screenAwareSize;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../card_title.dart';
import 'slider.dart';

class SliderCard extends StatelessWidget {
  final int inputValue;
  final String title;
  final ValueChanged<int> onChanged;
  final minValue;
  final maxValue;
  final bool small;

  const SliderCard(
      {Key key,
      this.inputValue = 18,
      this.onChanged,
      @required this.title,
      this.minValue = 1,
      this.maxValue = 110,
      this.small = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        left: screenAwareSize(16.0, context),
        right: screenAwareSize(4.0, context),
        bottom: screenAwareSize(4.0, context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CardTitle("$title", subtitle: "(kg)"),
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenAwareSize(16.0, context)),
                child: _drawSlider(
                    minValue: minValue, maxValue: maxValue, small: small),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawSlider({minValue, maxValue, bool small}) => SliderBackground(
        small: small,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return constraints.isTight
                ? Container()
                : CustomSlider(
                    minValue: minValue,
                    maxValue: maxValue,
                    value: inputValue,
                    onChanged: (val) => onChanged(val),
                    width: constraints.maxWidth,
                  );
          },
        ),
      );
}

class SliderBackground extends StatelessWidget {
  final Widget child;
  final bool small;

  const SliderBackground({Key key, this.child, this.small = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: screenAwareSize(small ? 50.0 : 100, context),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius:
                new BorderRadius.circular(screenAwareSize(10.0, context)),
          ),
          child: child,
        ),
        SvgPicture.asset(
          "images/inputValue_arrow.svg",
          height: screenAwareSize(10.0, context),
          width: screenAwareSize(18.0, context),
        ),
      ],
    );
  }
}
