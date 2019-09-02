import 'package:mplanner/healthCal/animation/counter.dart';
import 'package:mplanner/healthCal/app_bar.dart';
import 'package:mplanner/healthCal/calculator.dart'
    as calculator;
import 'package:mplanner/healthCal/functions/leanMassResult.dart';
import 'package:mplanner/healthCal/inputs/input_page_styles.dart';
import 'package:mplanner/healthCal/maths/maths.dart';
import 'package:mplanner/healthCal/model/gender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LeanMassResultPage extends StatefulWidget {
  final int height;
  final int weight;
  final Gender gender;

  const LeanMassResultPage({Key key, this.height, this.weight, this.gender})
      : super(key: key);

  @override
  _LeanMassResultPageState createState() => _LeanMassResultPageState();
}

class _LeanMassResultPageState extends State<LeanMassResultPage> {
  final _controller = LeanMassResult();

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
          title: 'Lean Mass',
        ),
        preferredSize: Size.fromHeight(appBarHeight(context)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Observer(
            builder: (_) => ResultCard(
              bmi: _controller.count,
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
                 /*  Share.text(
                      'My current Body Fat Percentage is:',
                      ' ${_controller.count.round()}%.'
                          ' Checkout https://healthkonnet.com.ng',
                      'text/plain'); */
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
    _controller.changeCount(leanMassCalculator(
        height: widget.height, weight: widget.weight, gender: widget.gender));
  }

  showInfo() => showModalBottomSheet(
      context: context,
      builder: (builder) {
        return new Container(
          height: 350.0,
          color: Colors.transparent, //could change this to Color(0xFF737373),
          //so you don't have to change MaterialApp canvasColor
          child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0))),
              child: new Center(
                child: new Text("This is a modal sheet"),
              )),
        );
      });
}

class ResultCard extends StatefulWidget {
  final double bmi;
  final double minWeight;
  final double maxWeight;

  final Gender gender;

  ResultCard(
      {Key key,
      this.bmi,
      this.minWeight,
      this.maxWeight,
      @required this.gender})
      : super(key: key);

  @override
  _ResultCardState createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Container(
          width: double.infinity,
          child: Column(children: [
            Text(
              widget.gender == Gender.female ? '🏋🏼‍♀️' : '🏋🏽‍♂️ ',
              style: TextStyle(fontSize: 80.0),
            ),
            AnimatedCount(
              count: double.parse(widget.bmi.toStringAsFixed(1)),
              duration: Duration(seconds: 3),
              curve: Curves.elasticOut,
            ),
            Text(
              'Lean Mass Index',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Lean Mass Index for weight range for the height:\n${widget.minWeight.round()}kg - ${widget.maxWeight.round()}kg',
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
