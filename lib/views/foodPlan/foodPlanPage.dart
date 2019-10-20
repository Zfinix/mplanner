import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:mplanner/models/foodData.dart';
import 'package:mplanner/utils/margin.dart';
import 'package:mplanner/utils/size.dart';

class FoodPlanPage extends StatefulWidget {
  final FoodDataModel foodData;
  FoodPlanPage({Key key, this.foodData}) : super(key: key);

  _FoodPlanPageState createState() =>
      _FoodPlanPageState(foodData);
}

class _FoodPlanPageState extends State<FoodPlanPage> {
  var _currentDate = DateTime.now();
  FoodDataModel foodDataModel;
  FoodData _selectedItem;
  _FoodPlanPageState(this.foodDataModel);

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedItem = foodDataModel.data[0];
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
                Column(
                  children: <Widget>[
                    //Loading the food into a list to display it
                    for (var i = 0; i < _selectedItem.content.length; i++)
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 28.0),
                            child: Row(
                              children: <Widget>[
                                Text(_selectedItem.content[i].type,
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
                                Text(_selectedItem.content[i].desc,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w400)),

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
          _selectedItem = foodDataModel.data[0];
        } else if (m.weekday == 2) {
          _selectedItem = foodDataModel.data[1];
        } else if (m.weekday == 3) {
          _selectedItem = foodDataModel.data[2];
        } else if (m.weekday == 4) {
          _selectedItem = foodDataModel.data[3];
        } else if (m.weekday == 5) {
          _selectedItem = foodDataModel.data[4];
        } else if (m.weekday == 6) {
          _selectedItem = foodDataModel.data[5];
        } else {
          print(foodDataModel.data.length);

          _selectedItem = foodDataModel.data[6];
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
