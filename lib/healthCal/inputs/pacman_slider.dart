import 'dart:math' as math;

import 'package:mplanner/healthCal/functions/pacmanSlider.dart';
import 'package:mplanner/healthCal/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
const double _pacmanWidth = 21.0;
const double _sliderHorizontalMargin = 24.0;
const double _dotsLeftMargin = 8.0;

class PacmanSliderM extends StatefulWidget {
  final VoidCallback onSubmit;
  final AnimationController submitAnimationController;

  const PacmanSliderM({Key key, this.onSubmit, this.submitAnimationController})
      : super(key: key);

  @override
  _PacmanSliderMState createState() => _PacmanSliderMState();
}

class _PacmanSliderMState extends State<PacmanSliderM>
    with TickerProviderStateMixin {
  final _controller = PacmanSliderController();

  @override
  void initState() {
    super.initState();
    _controller.changePacmanMovementController(AnimationController(
        vsync: this, duration: Duration(milliseconds: 400)));

    _controller.changeBordersAnimation(BorderRadiusTween(
      begin: BorderRadius.circular(8.0),
      end: BorderRadius.circular(50.0),
    ).animate(CurvedAnimation(
      parent: widget.submitAnimationController,
      curve: Interval(0.0, 0.07),
    )));
  }

  @override
  void dispose() {
    _controller.pacmanMovementController.dispose();
    super.dispose();
  }

  double get width => _controller.submitWidthAnimation?.value ?? 0.0;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => LayoutBuilder(
            builder: (context, constraints) { 
              _controller.changeSubmitWidthAnimation(Tween<double>(
                begin: constraints.maxWidth,
                end: screenAwareSize(52.0, context),
              ).animate(CurvedAnimation(
                parent: widget.submitAnimationController,
                curve: Interval(0.05, 0.15),
              )));

              return AnimatedBuilder(
                animation: widget.submitAnimationController,
                builder: (context, child) {
                  Decoration decoration = BoxDecoration(
                    borderRadius: _controller.bordersAnimation.value,
                    color: Theme.of(context).primaryColor,
                  );

                  return Center(
                    child: Container(
                      height: screenAwareSize(52.0, context),
                      width: width,
                      decoration: decoration,
                      child: _controller.submitWidthAnimation.isDismissed
                          ? GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () => _animatePacmanToEnd(),
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: <Widget>[
                                  AnimatedDots(),
                                  _drawDotCurtain(decoration),
                                  _drawPacman(),
                                ],
                              ),
                            )
                          : Container(),
                    ),
                  );
                },
              );
            },
          ),
    );
  }

  Widget _drawDotCurtain(Decoration decoration) {
    if (width == 0.0) {
      return Container();
    }
    double marginRight = width -
        _controller.pacmanPosition -
        screenAwareSize(_pacmanWidth / 2, context);
    return
      Positioned.fill(
            right: marginRight,
            child: Container(decoration: decoration),
      
    );
  }

  Widget _drawPacman() {
    _controller.changePacmanAnimation(_initPacmanAnimation());
    return Observer(
      builder: (_) => Positioned(
            left: _controller.pacmanPosition,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) =>
                  _onPacmanDrag(width, details),
              onHorizontalDragEnd: (details) => _onPacmanEnd(width, details),
              child: PacmanIcon(),
            ),
          ),
    );
  }

  Animation<double> _initPacmanAnimation() {
    Animation<double> animation = Tween(
      begin: _pacmanMinPosition(),
      end: _pacmanMaxPosition(width),
    ).animate(_controller.pacmanMovementController);

    animation.addListener(() {
      _controller.changePacmanPosition(animation.value);

      if (animation.status == AnimationStatus.completed) {
        _onPacmanSubmited();
      }
    });
    return animation;
  }

  _onPacmanSubmited() {
    widget?.onSubmit();
    Future.delayed(Duration(seconds: 1), () => _resetPacman());
  }

  _onPacmanDrag(double width, DragUpdateDetails details) {
    _controller
        .changePacmanPosition(_controller.pacmanPosition + details.delta.dx);

    _controller.changePacmanPosition(math.max(_pacmanMinPosition(),
        math.min(_pacmanMaxPosition(width), _controller.pacmanPosition)));
  }

  _onPacmanEnd(double width, DragEndDetails details) {
    bool isOverHalf = _controller.pacmanPosition +
            screenAwareSize(_pacmanWidth / 2, context) >
        0.5 * width;
    if (isOverHalf) {
      _animatePacmanToEnd();
    } else {
      _resetPacman();
    }
  }

  _animatePacmanToEnd() {
    _controller.pacmanMovementController
        .forward(from: _controller.pacmanPosition / _pacmanMaxPosition(width));
  }

  _resetPacman() {
    if (this.mounted) {
      _controller.changePacmanPosition(_pacmanMinPosition());
    }
  }

  double _pacmanMinPosition() =>
      screenAwareSize(_sliderHorizontalMargin, context);

  double _pacmanMaxPosition(double sliderWidth) =>
      sliderWidth -
      screenAwareSize(_sliderHorizontalMargin / 2 + _pacmanWidth, context);
}

class AnimatedDots extends StatefulWidget {
  @override
  _AnimatedDotsState createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<AnimatedDots>
    with TickerProviderStateMixin {
  final int numberOfDots = 10;
  final double minOpacity = 0.1;
  final double maxOpacity = 0.5;
  AnimationController hintAnimationController;

  @override
  void initState() {
    super.initState();
    _initHintAnimationController();
    hintAnimationController.forward();
  }

  @override
  void dispose() {
    hintAnimationController.dispose();
    super.dispose();
  }

  void _initHintAnimationController() {
    hintAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    hintAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 800), () {
          if (this.mounted) {
            hintAnimationController.forward(from: 0.0);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: screenAwareSize(
              _sliderHorizontalMargin + _pacmanWidth + _dotsLeftMargin,
              context),
          right: screenAwareSize(_sliderHorizontalMargin, context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(numberOfDots, _generateDot)
          ..add(Opacity(
            opacity: maxOpacity,
            child: Dot(size: 14.0),
          )),
      ),
    );
  }

  Widget _generateDot(int dotNumber) {
    Animation animation = _initDotAnimation(dotNumber);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Opacity(
            opacity: animation.value,
            child: child,
          ),
      child: Dot(size: 9.0),
    );
  }

  Animation<double> _initDotAnimation(int dotNumber) {
    double lastDotStartTime = 0.4;
    double dotAnimationDuration = 0.5;
    double begin = lastDotStartTime * dotNumber / numberOfDots;
    double end = begin + dotAnimationDuration;
    return SinusoidalAnimation(min: minOpacity, max: maxOpacity).animate(
      CurvedAnimation(
        parent: hintAnimationController,
        curve: Interval(begin, end),
      ),
    );
  }
}

class SinusoidalAnimation extends Animatable<double> {
  SinusoidalAnimation({this.min, this.max});

  final double min;
  final double max;

  @override
  double transform(double t) {
    return min + (max - min) * math.sin(math.pi * t);
  }
}

class Dot extends StatelessWidget {
  final double size;

  const Dot({Key key, @required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenAwareSize(size, context),
      width: screenAwareSize(size, context),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }
}

class PacmanIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: screenAwareSize(16.0, context),
      ),
      child: Image.asset(
        'images/pacman.png',
        height: screenAwareSize(35.0, context),
        width: screenAwareSize(31.0, context),
      ),
    );
  }
}
