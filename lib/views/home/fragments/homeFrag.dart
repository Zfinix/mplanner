import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:mplanner/models/foodData.dart';
import 'package:mplanner/models/recipes.dart';
import 'package:mplanner/models/userModel.dart';
import 'package:mplanner/utils/db.dart';
import 'package:mplanner/utils/margin.dart';
import 'package:mplanner/utils/size.dart';
import 'package:mplanner/views/auth/baseAuth.dart';
import 'package:mplanner/views/chat/util/database.dart';
import 'package:mplanner/views/home/profilePage.dart';
import 'package:mplanner/views/recipes/addRecipe.dart';
import 'package:mplanner/views/recipes/recipesDetailPage.dart';
import 'package:mplanner/widgets/recipeWidget.dart';
import 'package:mplanner/views/intersit/intersitPage.dart';

import '../dbDetails.dart';
import 'package:mplanner/views/foodPlan/foodPlanPage.dart';

class HomeFragment extends StatefulWidget {
  final profileNode;
  final Widget child;
  final UserModel userModel;

  HomeFragment(
      {Key key,
      this.child,
      @required this.profileNode,
      @required this.userModel})
      : super(key: key);

  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  FirebaseDatabase database;

  BaseAuth auth = new Auth();

  var reference;
  bool hasData = false;

  @override
  void initState() {
    database = FirebaseDatabase.instance;
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    setState(() {
      reference = database.reference().child('recipes');
    });
    super.initState();
  }

  loadData() async {
    var t = await reference.once();
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
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodPlanPage(
                    foodData: FoodDataModel.fromJson(foodJSONData),
                  ),
                ),
              );
            },
            tooltip: 'Food Calendar',
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              if (widget.userModel != null)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      userModel: widget.userModel,
                      profileNode: widget.profileNode,
                    ),
                  ),
                );
            },
            tooltip: 'Profile',
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              auth.signOut(context);
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => IntersitPage(),
                ),
              );
            },
            tooltip: 'Logout',
          )
        ],
      ),
      body: Container(
        height: screenHeight(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            hasData
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0, top: 50),
                        child: Text(
                          'DIABETES TIPS',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12),
                        ),
                      ),
                      DBTips(),
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0, top: 35),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                'RECIPIES',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 12),
                              ),
                              yMargin40,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Opacity(
                                    opacity: 0.09,
                                    child: Container(
                                      width: 80,
                                      height: 80,
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
                                'No Recipies Yet',
                                style: TextStyle(fontWeight: FontWeight.w200),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
            new Flexible(
              child: new FirebaseAnimatedList(
                query: reference,

                padding: const EdgeInsets.all(8.0),
                sort: (a, b) => b.key.compareTo(a.key),
                //comparing timestamp of messages to check which one would appear first
                itemBuilder: (_, DataSnapshot dataSnapshot,
                    Animation<double> animation, int i) {
                  var recipe = Recipes.fromSnapshot(dataSnapshot);

                  if (i == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 35.0, top: 50),
                          child: Text(
                            'DIABETES TIPS',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 12),
                          ),
                        ),
                        DBTips(),
                        Padding(
                          padding: const EdgeInsets.only(left: 35.0, top: 50),
                          child: Text(
                            'RECIPIES',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 12),
                          ),
                        ),
                        GestureDetector(
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
                          child: new RecipeCard(recipe: recipe),
                        )
                      ],
                    );
                  } else {
                    return new RecipeCard(recipe: recipe);
                  }
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
                fullscreenDialog: true, builder: (context) => AddRecipe()),
          );
        },
        child: Icon(
          Icons.receipt,
          color: Colors.white,
        ));
  }
}

class DBTips extends StatelessWidget {
  const DBTips({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.37,
      width: MediaQuery.of(context).size.width * 0.9,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dbitems?.length ?? 0,
        itemBuilder: (BuildContext context, int i) {
          return DBCard(dbItem: dbitems[i]);
        },
      ),
    );
  }
}

class DBCard extends StatelessWidget {
  final DBItem dbItem;
  const DBCard({Key key, this.dbItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: EdgeInsets.all(17),
      margin: EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.grey[700],
        image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.74), BlendMode.multiply),
            image: AssetImage('assets/images/${dbItem?.image}.jpg')),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => DBDetails(dbItem: dbItem),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(dbItem?.title ?? 'LOREM IPSUM',
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
            customYMargin(13),
            Text(dbItem?.desc ?? 'lOREM Ipsum dor esit',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 13,
                    height: 1.3,
                    color: Colors.white,
                    fontWeight: FontWeight.w300)),
          ],
        ),
      ),
    );
  }
}

class DBItem {
  final title, desc, image;

  DBItem({@required this.title, @required this.desc, @required this.image});
}
