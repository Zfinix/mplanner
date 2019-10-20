
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:mplanner/models/foodData.dart';
import 'package:mplanner/models/userModel.dart';
import 'package:mplanner/utils/margin.dart';
import 'package:mplanner/utils/size.dart';
import 'package:mplanner/views/foodPlan/addFoodPlan.dart';
import 'package:mplanner/widgets/foodPlanWidget.dart';


class FoodPlanFragment extends StatefulWidget {
  final Widget child;
  final UserModel userModel;
  final profileNode;

  FoodPlanFragment({Key key, this.child, this.userModel, this.profileNode})
      : super(key: key);

  _FoodPlanFragmentState createState() => _FoodPlanFragmentState();
}

class _FoodPlanFragmentState extends State<FoodPlanFragment> {
  FirebaseDatabase database;

  var foodPlanRef;

  bool hasData = false;

  @override
  void initState() {
    database = FirebaseDatabase.instance;
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    setState(() {
      foodPlanRef = database.reference().child('foodPlan');
    });
    super.initState();
  }

  loadData() async {
    var t = await foodPlanRef.once();
    if (t.value != null) {
      setState(() {
        hasData = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Plan'),
      ),
      body: Container(
        height: screenHeight(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            hasData
                ? Container()
                : 
                      Padding(
                        padding: const EdgeInsets.only(top: 65),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Opacity(
                                    opacity: 0.2,
                                    child: Container(
                                      width: 110,
                                      height: 110,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(90),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  'https://media.istockphoto.com/vectors/open-box-icon-vector-id635771440?k=6&m=635771440&s=612x612&w=0&h=IESJM8lpvGjMO_crsjqErVWzdI8sLnlf0dljbkeO7Ig=',
                                                  scale: 3))),
                                    ),
                                  ),
                                ],
                              ),
                              yMargin20,
                              Center(
                                  child: Text(
                                'No Meal Plans Yet',
                                style: TextStyle(
                                  color: Colors.white38,
                                  fontWeight: FontWeight.w100),
                              )),
                            ],
                          ),
                        ),
                      ),
                   
            new Flexible(
              child: new FirebaseAnimatedList(
                query: foodPlanRef,
                padding: const EdgeInsets.all(8.0),
                sort: (a, b) => b.key.compareTo(a.key),
                //comparing timestamp of messages to check which one would appear first
                itemBuilder: (_, DataSnapshot dataSnapshot,
                    Animation<double> animation, int i) {
                  var foodModel = FoodDataModel.fromMap(dataSnapshot.value);
                  // print(foodModel.data.length);
                  return  FoodPlanWidget(
                      foodModel: foodModel);
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: _buildFab(),
    );
  }

  _buildFab() {
    return FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => AddFoodPlanPage()),
          );
        },
        child: Icon(
          Icons.fastfood,
          color: Colors.white,
        ));
  }
}
