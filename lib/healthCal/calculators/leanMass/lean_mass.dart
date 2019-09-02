import 'package:mplanner/healthCal/functions/leanMass.dart';
import 'package:mplanner/healthCal/inputs/gender/gender_card.dart';
import 'package:mplanner/healthCal/inputs/height/height_card.dart';
import 'package:mplanner/healthCal/inputs/pacman_slider.dart';
import 'package:mplanner/healthCal/inputs/sliderSelector/slider_card.dart';
import 'package:mplanner/healthCal/inputs/transition_dot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:mplanner/healthCal/fade_route.dart';
import 'package:mplanner/healthCal/model/gender.dart';
import 'package:mplanner/healthCal/widget_utils.dart';
import 'result.dart';

class LeanMassInputPage extends StatefulWidget {
  @override
  LeanMassInputPageState createState() {
    return new LeanMassInputPageState();
  }
}

class LeanMassInputPageState extends State<LeanMassInputPage>
    with TickerProviderStateMixin {
  AnimationController _submitAnimationController;

  final _controller = LeanMass();

  @override
  void initState() {
    super.initState();
    _submitAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _submitAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _goToResultPage().then((_) => _submitAnimationController.reset());
      }
    });
  }

  @override
  void dispose() {
    _submitAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Text(
              'Lean Mass',
              style: TextStyle(color: Colors.black),
            ),
            brightness: Brightness.dark,
            backgroundColor: Colors.white,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Observer(
                builder: (_) => InputSummaryCard(
                  gender: _controller.gender,
                  weight: _controller.weight,
                  height: _controller.height,
                ),
              ),
              Expanded(child: _buildCards(context)),
              _buildBottom(context),
            ],
          ),
        ),
        TransitionDot(animation: _submitAnimationController),
      ],
    );
  }

  Widget _buildCards(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Observer(
                  builder: (_) => SliderCard(
                    inputValue: _controller.weight,
                    onChanged: (val) => _controller.changeWeight(val),
                    title: 'WEIGHT',
                  ),
                ),
              ),
              Expanded(
                child: Observer(
                  builder: (_) => GenderCard(
                    gender: _controller.gender,
                    onChanged: (val) => _controller.changeGender(val),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Observer(
            builder: (_) => HeightCard(
                height: _controller.height,
                onChanged: (val) => _controller.changeHeight(val)),
          ),
        )
      ],
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: screenAwareSize(16.0, context),
        right: screenAwareSize(16.0, context),
        bottom: screenAwareSize(22.0, context),
        top: screenAwareSize(14.0, context),
      ),
      child: PacmanSliderM(
        submitAnimationController: _submitAnimationController,
        onSubmit: onPacmanSubmit,
      ),
    );
  }

  void onPacmanSubmit() {
    _submitAnimationController.forward();
  }

  _goToResultPage() async {
    return Navigator.of(context).push(FadeRoute(
      builder: (context) => LeanMassResultPage(
        weight: _controller.weight,
        height: _controller.height,
        gender: _controller.gender,
      ),
    ));
  }
}

class InputSummaryCard extends StatelessWidget {
  final Gender gender;
  final int height;
  final int weight;

  const InputSummaryCard({Key key, this.gender, this.height, this.weight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(screenAwareSize(16.0, context)),
      child: SizedBox(
        height: screenAwareSize(32.0, context),
        child: Row(
          children: <Widget>[
            Expanded(child: _genderText()),
            _divider(),
            Expanded(child: _text("${weight}kg")),
            _divider(),
            Expanded(child: _text("${height}cm")),
          ],
        ),
      ),
    );
  }

  Widget _genderText() {
    String genderText = gender == Gender.other
        ? '-'
        : (gender == Gender.male ? 'Male' : 'Female');
    return _text(genderText);
  }

  Widget _text(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Color.fromRGBO(143, 144, 156, 1.0),
        fontSize: 15.0,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _divider() {
    return Container(
      width: 1.0,
      color: Color.fromRGBO(151, 151, 151, 0.1),
    );
  }
}
