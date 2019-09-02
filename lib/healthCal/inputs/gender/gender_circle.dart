import 'package:flutter/material.dart';

import 'package:mplanner/healthCal/widget_utils.dart';
import 'gender_styles.dart';

class GenderCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleSize(context),
      height: circleSize(context),
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.circular(screenAwareSize(50.0, context)),
        color: Colors.grey[900],
      ),
    );
  }
}
