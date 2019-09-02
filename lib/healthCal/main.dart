import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_bar.dart';
import 'calculators/bmi/bmi.dart';
import 'calculators/bodyFat/body_fat.dart';
import 'calculators/leanMass/lean_mass.dart';
import 'fade_route.dart';
import 'inputs/input_page_styles.dart';

class FitnessDashboard extends StatefulWidget {
  FitnessDashboard({Key key}) : super(key: key);

  _FitnessDashboardState createState() => _FitnessDashboardState();
}

class _FitnessDashboardState extends State<FitnessDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: BmiAppBar(
          title: 'Health Calculators',
        ),
        preferredSize: Size.fromHeight(appBarHeight(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: new FitnessDashboardWidget(
                text: 'BMI Calculator',
                image: 'splash',
                onClick: () {
                  Navigator.of(context).push(FadeRoute(
                    builder: (context) => BMInputPage(),
                  ));
                },
              ),
            ),
            Center(
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: new FitnessDashboardWidget(
                      text: 'Lean Mass Calculator',
                      image: 'leanMass',
                      onClick: () {
                        Navigator.of(context).push(FadeRoute(
                          builder: (context) => LeanMassInputPage(),
                        ));
                      },
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: new FitnessDashboardWidget(
                      text: 'Body Fat Calculator',
                      image: 'bodyFat',
                      onClick: () {
                        Navigator.of(context).push(FadeRoute(
                          builder: (context) => BodyFatInputPage(),
                        ));
                      },
                    ),
                  ),
                ],
              ),
            ),
            /*  Flexible(
              flex: 1,
              child: new FitnessDashboardWidget(
                text: 'Steps Counter',
                image: 'fitness',
                onClick: () {
                  return Navigator.of(context).push(FadeRoute(
                    builder: (context) => DailyView(),
                  )); 
                },
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}

class FitnessDashboardWidget extends StatelessWidget {
  const FitnessDashboardWidget({
    Key key,
    @required this.image,
    @required this.text,
    @required this.onClick,
  }) : super(key: key);

  final image;
  final text;
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.all(9.0),
      elevation: 2,
      child: InkWell(
        onTap: onClick,
        child: Container(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 70,
                        child: Text('$text',
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,)),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 25),
                          height: 2,
                          width: 25,
                          color: Colors.amber)
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Flexible(
                child: SvgPicture.asset(
                  "images/$image.svg",
                  height: 50,
                  width: 50,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('$text',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey,
                      fontWeight: FontWeight.w200)),
            ],
          ),
        ),
      ),
    );
  }
}
