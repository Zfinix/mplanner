import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 70,
          ),
          Image.asset('images/splash.png'),
          SizedBox(
            height: 70,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Fitness',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      color: Colors.blueAccent)),
              Container(
                  padding: EdgeInsets.only(top: 25),
                  height: 2,
                  width: 55,
                  color: Colors.amber)
            ],
          ),
          SizedBox(
            height: 90,
          ),
          Container(
              height: 4,
              width: 100,
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
              )),
          SizedBox(
            height: 160,
          ),
          Text('By HealthKonnet',
              style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 18,
                  color: Colors.grey)),
        ],
      ),
    );
  }
}
