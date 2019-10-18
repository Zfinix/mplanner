import 'package:flutter/material.dart';
import 'package:mplanner/views/intersit/intersitPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MPlanner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.green,
          primarySwatch: Colors.lightGreen),
      home: IntersitPage()
    );
  }
}
