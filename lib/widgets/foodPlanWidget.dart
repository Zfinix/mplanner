import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mplanner/models/foodData.dart';
import 'package:mplanner/models/userModel.dart';
import 'package:mplanner/utils/margin.dart';
import 'package:mplanner/views/foodPlan/foodPlanPage.dart';
import 'package:mplanner/views/home/otherPage.dart';

class FoodPlanWidget extends StatelessWidget {
  final String name, imageUrl, profilePicUrl, desc, title;
  final DateTime timeStamp;
  final userId;
  final FoodDataModel foodModel;
  const FoodPlanWidget(
      {Key key,
      this.name,
      this.imageUrl,
      this.desc,
      this.title,
      this.profilePicUrl,
      this.timeStamp,
      @required this.userId,
      this.foodModel})
      : super(key: key);

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
                onTap: ()=>_gotoProfile(context),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 6,
                      child: MPAvatar(
                        name: name ?? '',
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

              imageUrl != null
                    ? Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(imageUrl))),
                      )
                    : Container(),
        yMargin30,
          Container(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    title ?? '',
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

    if(userId != null) {

    var v = (await FirebaseDatabase.instance
        .reference()
        .child('users')
        .orderByChild('userId').equalTo(userId).once());

    if (v.value != null) {

       var userModel = UserModel.fromMap(v.value.values.toList()[0]);

       Navigator.push(
         context,
         MaterialPageRoute(
           builder: (context) => OtherPage(
             userModel:userModel,
           ),
         ),
       );
     }
    }
  }
}

class MPAvatar extends StatelessWidget {
  final name;
  final url;
  const MPAvatar({Key key, this.name, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        title: Text(name ?? 'Anonymous'),
        leading: new CircleAvatar(
          backgroundImage: new NetworkImage(url ?? "https://bit.ly/2BCsKbI"),
        ),
      ),
    );
  }
}
