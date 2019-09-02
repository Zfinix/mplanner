import 'package:flutter/material.dart';
import 'package:mplanner/utils/margin.dart';
import 'package:mplanner/views/auth/loginPage.dart';
import 'package:mplanner/views/intersit/planPage.dart';

import 'package:mplanner/widgets/imageBgWidget.dart';

class IntersitPage extends StatefulWidget {
  _IntersitPageState createState() => _IntersitPageState();
}

class _IntersitPageState extends State<IntersitPage> {
  @override
  Widget build(BuildContext context) {
    return ImageBGScaffold(
      child: _buildUI(),
      bg: 'food1',
    );
  }

  _buildUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            customYMargin(300),
            Container(
              width: 200,
              child: Text('Start your Diet. Achieve Goals.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold)),
            ),
            yMargin50,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 169,
                    height: 50,
                    child: FlatButton(
                      child: Text(
                        'CREATE ACCOUNT',
                        style: TextStyle(fontSize: 12),
                      ),
                      color: Colors.lightGreen,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlanPage()));
                      },
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 165,
                    child: FlatButton(
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(fontSize: 12),
                      ),
                      color: Colors.white,
                      textColor: Colors.black,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
