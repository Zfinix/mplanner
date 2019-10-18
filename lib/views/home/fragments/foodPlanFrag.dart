import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:mplanner/models/foodData.dart';
import 'package:mplanner/models/userModel.dart';
import 'package:mplanner/utils/size.dart';
import 'package:mplanner/views/auth/baseAuth.dart';
import 'package:mplanner/views/foodPlan/addFoodPlan.dart';
import 'package:mplanner/widgets/recipeWidget.dart';


class AddFoodPlanFragment extends StatefulWidget {
  final Widget child;

  AddFoodPlanFragment({Key key, this.child}) : super(key: key);

  _AddFoodPlanFragmentState createState() => _AddFoodPlanFragmentState();
}

class _AddFoodPlanFragmentState extends State<AddFoodPlanFragment> {
  FirebaseDatabase database;

  var foodPlanRef;

  BaseAuth auth = new Auth();
  UserModel userModel;
  FirebaseUser user;

  bool hasData = false;
  String profileNode;

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

  loadUserData() async {
    user = await auth.getCurrentUser();
    var v = (await foodPlanRef.once());

    if (v.value != null) {
      setState(() {
        userModel = UserModel.fromMap(v.value.values.toList()[0]);
        profileNode = v.value.keys.toList()[0];
      });
    }
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

                  return new RecipeCard(
                      name: foodModel.name,
                      title: foodModel.title,
                      desc: foodModel.desc,
                      profilePicUrl: foodModel.photoUrl,
                      imageUrl: foodModel.imageUrl,
                      userId: foodModel.userId,
                      timeStamp: foodModel.timeStamp,
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
                builder: (context) => AddFoodPlanPage(user: user,)),
          );
        },
        child: Icon(
          Icons.fastfood,
          color: Colors.white,
        ));
  }
}
