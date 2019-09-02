import 'package:flutter/material.dart';

class AnimatedCount extends ImplicitlyAnimatedWidget {
  final double count;
  final String suffix;

  AnimatedCount(
      {Key key,
      @required this.count,
      this.suffix,
      @required Duration duration,
      Curve curve = Curves.linear})
      : super(duration: duration, curve: curve, key: key);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _AnimatedCountState();
}

class _AnimatedCountState extends AnimatedWidgetBaseState<AnimatedCount> {
  Tween _count;

  @override
  Widget build(BuildContext context) {
    return widget.suffix != null
        ? RichText(
            text: TextSpan(
            style: DefaultTextStyle.of(context).style.copyWith(fontSize: 34.0),
            children: [
              TextSpan(
                text:
                    double.parse(_count.evaluate(animation).toStringAsFixed(1))
                        .toString(),
                style: TextStyle(fontSize: 140.0, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: "${widget.suffix}",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              // TextSpan(text: isInputPage ? getEmoji(context) : ""),
            ],
          ))
        : Text(
            double.parse(_count.evaluate(animation).toStringAsFixed(1))
                .toString(),
            style: TextStyle(fontSize: 140.0, fontWeight: FontWeight.bold),
          );
  }

  @override
  void forEachTween(TweenVisitor visitor) {
    _count =
        visitor(_count, widget.count, (var value) => new Tween(begin: value));
  }
}
