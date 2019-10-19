
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:mplanner/models/foodData.dart';
import 'package:mplanner/models/recipes.dart';
import 'package:mplanner/models/userModel.dart';
import 'package:mplanner/utils/margin.dart';
import 'package:mplanner/views/auth/baseAuth.dart';
import 'package:mplanner/views/recipes/recipesDetailPage.dart';
import 'package:mplanner/widgets/recipeWidget.dart';

class OtherPage extends StatefulWidget {
  final UserModel userModel;
  OtherPage({Key key, this.userModel}) : super(key: key);

  _OtherPageState createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> with TickerProviderStateMixin {
  TabController _controller;
  int _tab = 0;
  BaseAuth auth = new Auth();
  UserModel personalProfile;
  bool hasData = false;

  @override
  void initState() {
    super.initState();
    loadUserData();
    _controller = new TabController(length: 2, vsync: this);
  }

  loadUserData() async {
    var user = await auth.getCurrentUser();
    var v = (await FirebaseDatabase.instance
        .reference()
        .child('users')
        .orderByChild('userId')
        .equalTo(user.uid)
        .once());

    if (v.value != null) {
      setState(() {
        personalProfile = UserModel.fromMap(v.value.values.toList()[0]);
      });
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 5,
              child: Scaffold(
                body: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 5,
                      child: new TabBarView(
                        controller: _controller,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Flexible(
                                flex: 3,
                                child: Column(children: <Widget>[
                                  customYMargin(20),
                                  Container(
                                      height: 96,
                                      width: 96,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(220),
                                        color: Colors.white,
                                        boxShadow: [
                                          new BoxShadow(
                                            offset: Offset(6, 20),
                                            spreadRadius: -17,
                                            blurRadius: 14,
                                          ),
                                        ],
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                widget.userModel.userPhotoUrl ??
                                                    'https://bit.ly/2BCsKbI')),
                                      )),
                                  Text(widget?.userModel?.userName ?? '',
                                      style: TextStyle(
                                          fontSize: 23, fontWeight: FontWeight.bold)),
                                  customYMargin(10),
                                  Text(widget?.userModel?.email ?? '',
                                      style: TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.w300)),
                                  customYMargin(6),
                                  Text(widget?.userModel?.bio ?? '',
                                      style: TextStyle(
                                          fontSize: 10, fontWeight: FontWeight.w200)),
                                  customYMargin(10)
                                ]),
                              ),
                              Divider(),
                              Flexible(
                                flex:5,
                                child: new FirebaseAnimatedList(
                                  query: FirebaseDatabase.instance
                                      .reference()
                                      .child('foodPlan'),
                                  padding: const EdgeInsets.all(8.0),

                                  key: new PageStorageKey('meals'),
                                  sort: (a, b) => b.key.compareTo(a.key),
                                  //comparing timestamp of messages to check which one would appear first
                                  itemBuilder: (_, DataSnapshot dataSnapshot,
                                      Animation<double> animation, int i) {
                                    var foodModel =
                                        FoodDataModel.fromMap(dataSnapshot.value);
                                    // print(foodModel.data.length);
                                    if (widget?.userModel?.userId ==
                                        personalProfile?.userId) {


                                      return new RecipeCard(
                                          name: foodModel.name,
                                          title: foodModel.title,
                                          desc: foodModel.desc,
                                          profilePicUrl: foodModel.photoUrl,
                                          imageUrl: foodModel.imageUrl,
                                          userId: null,
                                          timeStamp: foodModel.timeStamp,
                                          foodModel: foodModel);
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          new FirebaseAnimatedList(
                            query: FirebaseDatabase.instance
                                .reference()
                                .child('recipes'),
                            padding: const EdgeInsets.all(8.0),
                            sort: (a, b) => b.key.compareTo(a.key),
                            //comparing timestamp of messages to check which one would appear first
                            itemBuilder: (_, DataSnapshot dataSnapshot,
                                Animation<double> animation, int i) {
                              var recipe = Recipes.fromSnapshot(dataSnapshot);

                              if (widget.userModel.userId ==
                                  personalProfile.userId) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          fullscreenDialog: true,
                                          builder: (context) => RecipeDetails(
                                                recipe: recipe,
                                              )),
                                    );
                                  },
                                  child: new RecipeCard(
                                      name: recipe.name,
                                      title: recipe.title,
                                      desc: recipe.description,
                                      profilePicUrl: recipe.profilePicUrl,
                                      imageUrl: recipe.imageUrl,
                                      userId: recipe.userId,
                                      timeStamp: recipe.timestamp),
                                );
                              } else {
                                return Container();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: new BottomNavigationBar(
                  selectedItemColor: Colors.green,
                  backgroundColor: Colors.white,
                  type: BottomNavigationBarType.shifting,
                  unselectedItemColor: Colors.grey,
                  onTap: (int value) {
                    _controller.animateTo(value);
                    setState(() {
                      _tab = value;
                    });
                  },
                  currentIndex: _tab,
                  items: <BottomNavigationBarItem>[
                    new BottomNavigationBarItem(
                      icon: new Icon(Icons.fastfood),
                      title: new Text('Meal Plans'),
                    ),
                    new BottomNavigationBarItem(
                      icon: new Icon(Icons.receipt),
                      title: new Text('Recipies'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
