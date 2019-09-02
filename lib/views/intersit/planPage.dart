import 'package:mplanner/utils/margin.dart';
import 'package:flutter/material.dart';
import 'package:mplanner/views/auth/signupPage.dart';
import 'package:mplanner/widgets/imageBgWidget.dart';

class PlanPage extends StatefulWidget {
  _PlanPageState createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  @override
  Widget build(BuildContext context) {
    return ImageBGScaffold(
      child: _buildUI(),
      bg: 'intersit1',
    );
  }

  _buildUI() {
    return Container(
      color: Colors.black.withOpacity(0.4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  yMargin50,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Get your Meal Plan',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  yMargin20,
                  Text(
                      'With just few taps, get your customised meal plan and lead a healthy lifestyle,',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w200)),
                  yMargin30,
                  Container(
                      child: Column(
                    children: <Widget>[
                      CheckItem(text: 'Customise a 7 day meal plan'),
                      CheckItem(text: 'Easily Calculate your BMI'),
                      CheckItem(text: 'Check the amount of calorie per day'),
                      CheckItem(text: 'Exercise and tips if you have diabetics')
                    ],
                  ))
                ],
              ),
            ),
          ),
          yMargin100,
          Container(
              height: 70,
              width: MediaQuery.of(context).size.height,
              child: FlatButton(
                child: Text('YAY, SIGN ME UP'),
                color: Colors.lightGreen,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
              ))
        ],
      ),
    );
  }
}

class CheckItem extends StatelessWidget {
  final String text;

  CheckItem({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.check),
          xMargin10,
          Text('$text'),
        ],
      ),
    );
  }
}
