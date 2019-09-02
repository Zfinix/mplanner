import 'package:mplanner/healthCal/animation/counter.dart';
import 'package:mplanner/healthCal/app_bar.dart';
import 'package:mplanner/healthCal/calculator.dart'
    as calculator;
import 'package:mplanner/healthCal/datastore/data.dart';
import 'package:mplanner/healthCal/functions/bodyFatResult.dart';
import 'package:mplanner/healthCal/inputs/input_page_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mplanner/healthCal/maths/maths.dart';
import 'package:mplanner/healthCal/model/gender.dart';

class BodyFatResultPage extends StatefulWidget {
  final int height;
  final int weight;
  final int age;
  final Gender gender;

  const BodyFatResultPage(
      {Key key,
      this.height = 0,
      this.weight = 0,
      this.gender = Gender.male,
      this.age = 0})
      : super(key: key);

  @override
  _BodyFatResultPageState createState() => _BodyFatResultPageState();
}

class _BodyFatResultPageState extends State<BodyFatResultPage> {
  final _controller = BodyFatResult();
  String text = '';

  @override
  void initState() {
    delayCounter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: BmiAppBar(
          title: 'Body Fat',
        ),
        preferredSize: Size.fromHeight(appBarHeight(context)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Observer(
            builder: (_) => ResultCard(
              value: _controller.count,
              minWeight:
                  calculator.calculateMinNormalWeight(height: widget.height),
              maxWeight:
                  calculator.calculateMaxNormalWeight(height: widget.height),
              gender: widget.gender,
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: IconButton(
              icon: Icon(
                Icons.info_outline,
                color: Colors.grey,
                size: 28.0,
              ),
              onPressed: () => showInfo(),
            ),
          ),
          Container(
              height: 52.0,
              width: 80.0,
              child: RaisedButton(
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 28.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                onPressed: () => Navigator.of(context).pop(),
                color: Theme.of(context).primaryColor,
              )),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Observer(
              builder: (_) => IconButton(
                icon: Icon(
                  Icons.share,
                  color: Colors.grey,
                  size: 28.0,
                ),
                onPressed: () {
                   /* Share.text('My current Body Fat Percentage is:',
                      ' ${_controller.count.round()}%.'
                      ' Checkout https://healthkonnet.com.ng', 'text/plain');
    */
                 },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void delayCounter() async {
    await Future.delayed(Duration(seconds: 1));
    _controller.changeCount(bodyFatCalculator(
        height: widget.height,
        weight: widget.weight,
        gender: widget.gender,
        age: widget.age));
  }

  showInfo() => showModalBottomSheet(
      context: context,
      builder: (builder) {
        return new Container(
          height: 350.0,
          color: Colors.transparent, //could change this to Color(0xFF737373),
          //so you don't have to change MaterialApp canvasColor
          child: new Container(
              padding: EdgeInsets.all(20),
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0))),
              child: ListView(
                children: <Widget>[
                  new Center(
                    child: new Text(bodyFat),
                  ),
                ],
              )),
        );
      });
}

class ResultCard extends StatefulWidget {
  final double value;
  final double minWeight;
  final double maxWeight;

  final Gender gender;

  ResultCard(
      {Key key,
      this.value,
      this.minWeight,
      this.maxWeight,
      @required this.gender})
      : super(key: key);

  @override
  _ResultCardState createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  final _controller = BodyFatResult();

  @override
  void initState() {
    delayText();
    super.initState();
  }

  void delayText() async {
    await Future.delayed(Duration(seconds: 5));
    _controller.changeText(status());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Container(
          width: double.infinity,
          child: Column(children: [
            Observer(
              builder: (_) => Text(
                _controller.text,
                style: TextStyle(fontSize: 40.0),
              ),
            ),
            AnimatedCount(
              suffix: '%',
              count: widget.value != null
                  ? double.parse((widget.value.toStringAsFixed(1)))
                  : 0.0,
              duration: Duration(seconds: 3),
              curve: Curves.elasticOut,
            ),
            Text(
              'Body Fat',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Body Fat Percentage for weight range for the height:\n${widget.minWeight.round()}kg - ${widget.maxWeight.round()}kg',
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  status() {
    print(widget.value);
    print(widget.gender);
    if (widget.gender == Gender.female) {
      if (widget.value != null && widget.value >= 14 && widget.value <= 20) {
        return 'Essential fat';
      } else if (widget.value != null &&
          widget.value > 20 &&
          widget.value <= 24) {
        return 'Athletes';
      } else if (widget.value != null &&
          widget.value > 24 &&
          widget.value <= 31) {
        return 'Fitness';
      } else {
        return widget.value != null && widget.value > 31
            ? 'Average'
            : 'Malnourished';
      }
    } else {
      if (widget.value != null && widget.value >= 2 && widget.value <= 5) {
        return 'Essential fat';
      } else if (widget.value != null &&
          widget.value > 5 &&
          widget.value <= 13) {
        return 'Athletes';
      } else if (widget.value != null &&
          widget.value > 13 &&
          widget.value <= 17) {
        return 'Fitness';
      } else if (widget.value != null &&
          widget.value > 17 &&
          widget.value <= 25) {
        return 'Average';
      } else {
        return widget.value != null && widget.value > 25
            ? 'Obese'
            : 'Malnourished';
      }
    }
  }
}
