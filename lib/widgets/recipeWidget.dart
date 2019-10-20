import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mplanner/models/recipes.dart';
import 'package:mplanner/models/userModel.dart';
import 'package:mplanner/utils/margin.dart';
import 'package:mplanner/views/chat/util/database.dart';
import 'package:mplanner/views/home/otherPage.dart';
import 'package:mplanner/views/recipes/recipesDetailPage.dart';

class RecipeCard extends StatelessWidget {
  final Recipes recipe;
  final bool canViewProfile;
  const RecipeCard({Key key, @required this.recipe, this.canViewProfile = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetails(
              recipe: recipe,
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
                        name: recipe?.name ?? '',
                        userId: recipe.userId,
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
              recipe.imageUrl != null
                  ? Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(recipe.imageUrl))),
                    )
                  : Container(),
              yMargin30,
              Container(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  recipe.title ?? '',
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
    if (recipe.userId != null && canViewProfile) {
      var v = (await FirebaseDatabase.instance
          .reference()
          .child('users')
          .orderByChild('userId')
          .equalTo(recipe.userId)
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

class MPAvatar extends StatelessWidget {
  final name;
  final userId;
  const MPAvatar({Key key, this.name, @required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
          title: Text(name ?? 'Anonymous'),
          leading: new FutureBuilder(
            future: getUserImage(userId),
            builder: (BuildContext context, AsyncSnapshot<String> image) {
              return new CircleAvatar(
                backgroundImage: new NetworkImage(
                    image.hasData ? image.data : "https://bit.ly/2BCsKbI"),
              ); // image is ready
            },
          )),
    );
  }
}
