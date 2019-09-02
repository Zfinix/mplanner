import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'inputs/input_page_styles.dart';
import 'widget_utils.dart';

class BmiAppBar extends StatelessWidget {
  final bool isInputPage;
  final String title;
  static const String wavingHandEmoji = "\uD83D\uDC4B";
  static const String whiteSkinTone = "\uD83C\uDFFB";

  const BmiAppBar({Key key, this.isInputPage = true, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1.0,
      child: Container(
        height: appBarHeight(context),
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: EdgeInsets.all(screenAwareSize(16.0, context)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildLabel(context),
            ],
          ),
        ),
      ),
    );
  }


  RichText _buildLabel(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style.copyWith(fontSize: 34.0),
        children: [
          TextSpan(
            text:  "$title",
            style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25),
          ),
         // TextSpan(text: isInputPage ? getEmoji(context) : ""),
        ],
      ),
    );
  }

  // https://github.com/flutter/flutter/issues/9652
  String getEmoji(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS
        ? wavingHandEmoji
        : wavingHandEmoji + whiteSkinTone;
  }
}
