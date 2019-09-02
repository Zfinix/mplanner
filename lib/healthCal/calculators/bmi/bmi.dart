import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mplanner/healthCal/calculators/bmi/result.dart';
import 'package:mplanner/healthCal/functions/bmi.dart';
import 'package:mplanner/healthCal/inputs/gender/gender_card.dart';
import 'package:mplanner/healthCal/inputs/height/height_card.dart';
import 'package:mplanner/healthCal/inputs/pacman_slider.dart';
import 'package:mplanner/healthCal/inputs/sliderSelector/slider_card.dart';
import 'package:mplanner/healthCal/inputs/transition_dot.dart';
import 'package:mplanner/healthCal/fade_route.dart';
import 'package:mplanner/healthCal/model/gender.dart';
import 'package:mplanner/healthCal/widget_utils.dart';

class BMInputPage extends StatefulWidget {
  @override
  BMInputPageState createState() {
    return new BMInputPageState();
  }
}

class BMInputPageState extends State<BMInputPage>
    with TickerProviderStateMixin {
  final _bmi = BMI();
  AnimationController _submitAnimationController;

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
              color: Colors.white, //change your color here
            ),
            title: Text(
              'BMI',
              style: TextStyle(color: Colors.white),
            ),
            brightness: Brightness.dark,
            
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Observer(
                builder: (_) => InputSummaryCard(
                  gender: _bmi.gender,
                  weight: _bmi.weight,
                  height: _bmi.height,
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
                    inputValue: _bmi.weight,
                    onChanged: (val) => _bmi.changeWeight(val),
                    title: 'WEIGHT',
                  ),
                ),
              ),
              Expanded(
                child: Observer(
                  builder: (_) => GenderCard(
                    gender: _bmi.gender,
                    onChanged: (val) => _bmi.changeGender(val),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Observer(
            builder: (_) => HeightCard(
              height: _bmi.height,
              onChanged: (val) => _bmi.changeHeight(val),
            ),
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
      builder: (context) => ResultPage(
        weight: _bmi.weight,
        height: _bmi.height,
        gender: _bmi.gender,
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
        color: Colors.white,
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
