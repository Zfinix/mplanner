import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mplanner/models/foodData.dart';
import 'package:mplanner/models/userModel.dart';
import 'package:mplanner/utils/margin.dart';
import 'package:mplanner/views/foodPlan/foodPlanPage.dart';
import 'package:mplanner/views/home/otherPage.dart';
import 'package:mplanner/widgets/recipeWidget.dart';

class FoodPlanWidget extends StatelessWidget {
  final FoodDataModel foodModel;
  final bool canViewProfile;

  const FoodPlanWidget({
    Key key,
    @required this.foodModel,
    this.canViewProfile = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodPlanPage(
              foodData: foodModel,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () => _gotoProfile(context),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 6,
                      child: MPAvatar(
                        name: foodModel?.name ?? '',
                        userId: foodModel.userId,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child:
                          IconButton(icon: Icon(Icons.share), onPressed: () {}),
                    ),
                  ],
                ),
              ),
              foodModel.imageUrl != null
                  ? Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(foodModel.imageUrl))),
                    )
                  : Container(),
              yMargin30,
              Container(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  foodModel.title ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _gotoProfile(context) async {
    if (foodModel.userId != null &&canViewProfile) {
      var v = (await FirebaseDatabase.instance
          .reference()
          .child('users')
          .orderByChild('userId')
          .equalTo(foodModel.userId)
          .once());

      if (v.value != null) {
        var userModel = UserModel.fromMap(v.value.values.toList()[0]);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtherPage(
              userModel: userModel,
            ),
          ),
        );
      }
    }
  }
}
