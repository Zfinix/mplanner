import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:mplanner/models/foodData.dart';
import 'package:mplanner/utils/margin.dart';
import 'package:mplanner/utils/size.dart';
import 'package:mplanner/views/chat/util/database.dart';

FoodData foodData;

class FoodPlanPage extends StatefulWidget {
  FoodPlanPage({Key key}) : super(key: key);

  _FoodPlanPageState createState() => _FoodPlanPageState();
}

class _FoodPlanPageState extends State<FoodPlanPage> {
  var _currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    setState(() {
      foodData = FoodDataModel.fromJson(foodJSONData).data[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Calendar'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                customYMargin(12),
                //Simple Calendar View
                CalendarWidget(
                  function: function,
                  currentDate: _currentDate,
                ),
                customYMargin(20),
                Column(
                  children: <Widget>[
                    //Loading the food into a list to display it
                    for (var i = 0; i < foodData.content.length; i++)
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 28.0),
                            child: Row(
                              children: <Widget>[
                                Text(foodData.content[i].type,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                          customYMargin(30),
                          Container(
                            width: screenWidth(context, percent: 0.88),
                            padding: const EdgeInsets.all(38.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: <Widget>[
                                Text(foodData.content[i].desc,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w400)),
                                /* customYMargin(20),
                                 Text(
                                    'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laud antium, totam rem aperiam…',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w200)),
                               */
                              ],
                            ),
                          ),
                          customYMargin(30),
                        ],
                      )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

//Function to select Day of the week
  function(DateTime m, List n) {
    try {
      this.setState(() {
        _currentDate = m;

        /* m.weekday is for getting  days of the week. Example m.weekday = 1 is monday 
        and so non till m.weekday = 7 is sunday*/

        //foodJSONData is data from our database

        if (m.weekday == 1) {
          foodData = FoodDataModel.fromJson(foodJSONData).data[0];
        } else if (m.weekday == 2) {
          foodData = FoodDataModel.fromJson(foodJSONData).data[1];
        } else if (m.weekday == 3) {
          foodData = FoodDataModel.fromJson(foodJSONData).data[2];
        } else if (m.weekday == 4) {
          foodData = FoodDataModel.fromJson(foodJSONData).data[3];
        } else if (m.weekday == 5) {
          foodData = FoodDataModel.fromJson(foodJSONData).data[4];
        } else if (m.weekday == 6) {
          foodData = FoodDataModel.fromJson(foodJSONData).data[5];
        } else {
          foodData = FoodDataModel.fromJson(foodJSONData).data[6];
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }
}

class CalendarWidget extends StatelessWidget {
  final Function function;
  final DateTime currentDate;
  CalendarWidget({Key key, this.function, this.currentDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel(
        selectedDateTime: this.currentDate,
        onDayPressed: this.function,
        thisMonthDayBorderColor: Colors.grey,
        height: 420.0,

        /// null for not rendering any border, true for circular border, false for rectangular border
        markedDatesMap: null,
        iconColor: Colors.white,
        selectedDayButtonColor: Colors.white,
        selectedDayTextStyle: TextStyle(color: Colors.green),
        weekdayTextStyle: TextStyle(color: Colors.white),
        headerTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        prevDaysTextStyle: TextStyle(color: Colors.white54),
        nextDaysTextStyle: TextStyle(color: Colors.white54),
        daysTextStyle: TextStyle(color: Colors.white),
        selectedDayBorderColor: Colors.green,
        todayButtonColor: Colors.lightGreen,
      ),
    );
  }
}

//Food Data converted to JSON to be easily accessed;
