import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mplanner/models/foodData.dart';
import 'package:mplanner/models/userModel.dart';
import 'package:mplanner/utils/margin.dart';
import 'package:mplanner/utils/size.dart';
import 'package:mplanner/views/auth/baseAuth.dart';

class AddFoodPlanPage extends StatefulWidget {
  _AddFoodPlanPageState createState() => _AddFoodPlanPageState();
}

class _AddFoodPlanPageState extends State<AddFoodPlanPage> {
  File image;
  FirebaseStorage _storage = FirebaseStorage.instance;
  UserModel userModel;
  bool isLoading = false;
  FoodDataModel foodDataModel;

  List<String> breakfastList = [];
  List<String> lunchList = [];
  List<String> dinnerList = [];

  final _formKey = GlobalKey<FormState>();
  String titleText, descText;

  BaseAuth auth = new Auth();
  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    userModel = await auth.getCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Food Plan'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          physics: ClampingScrollPhysics(),
          cacheExtent: 10000000,
          children: <Widget>[
            buildImage(),
            yMargin40,
            title(),
            desc(),
            yMargin40,
            Divider(),
            yMargin40,
            for (var i = 0; i < 7; i++)
              Column(
                children: <Widget>[
                  Text(
                    i == 0
                        ? 'Monday'
                        : i == 1
                            ? 'Tuesday'
                            : i == 2
                                ? 'Wednesday'
                                : i == 3
                                    ? 'Thursday'
                                    : i == 4
                                        ? 'Friday'
                                        : i == 5 ? 'Saturday' : 'Sunday',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                  yMargin10,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                        validator: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              breakfastList.add(value);
                            });
                            return null;
                          } else if (value.isEmpty) {
                            return "This field can't be left empty";
                          } else {
                            return "Field is Invalid";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "BREAKFAST",
                            labelStyle: TextStyle(fontSize: 13))),
                  ),
                  yMargin5,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                        validator: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              lunchList.add(value);
                            });
                            return null;
                          } else if (value.isEmpty) {
                            return "This field can't be left empty";
                          } else {
                            return "Field is Invalid";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "LUNCH",
                            labelStyle: TextStyle(fontSize: 13))),
                  ),
                  yMargin5,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                        validator: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              dinnerList.add(value);
                            });
                            return null;
                          } else if (value.isEmpty) {
                            return "This field can't be left empty";
                          } else {
                            return "Field is Invalid";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "DINNER",
                            labelStyle: TextStyle(fontSize: 13))),
                  ),
                  yMargin60,
                  i == 6
                      ? Column(
                          children: <Widget>[
                            !isLoading
                                ? Container(
                                    height: 50,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    child: FlatButton(
                                        child: Text(
                                          'UPLOAD FOOD PLAN',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        color: Colors.green,
                                        textColor: Colors.white,
                                        onPressed: () => addFoodPlan()),
                                  )
                                : Container(
                                    height: 45,
                                    width: 45,
                                    child: CircularProgressIndicator(),
                                  ),
                          ],
                        )
                      : Container()
                ],
              )
          ],
        ),
      ),
    );
  }

  buildImage() => Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => getImage(),
            child: Container(
              height: screenHeight(context, percent: 0.3),
              width: screenWidth(context),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                boxShadow: [
                  new BoxShadow(
                    offset: Offset(6, 30),
                    spreadRadius: -17,
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 19,
                  ),
                ],
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: image != null ? FileImage(image) : AssetImage('')),
              ),
              child: image == null
                  ? IconButton(
                      icon: Icon(Icons.add_a_photo,
                          color: Colors.green, size: 50),
                      onPressed: () async {
                        getImage();
                      },
                    )
                  : Container(),
            ),
          ),
        ],
      );

  title() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
          validator: (value) {
            if (value.isNotEmpty) {
              setState(() {
                titleText = value;
              });
              return null;
            } else if (value.isEmpty) {
              return "This field can't be left empty";
            } else {
              return "Field is Invalid";
            }
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.title),
              labelText: "RECIPE TITLE",
              labelStyle: TextStyle(fontSize: 13))),
    );
  }

  desc() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
          validator: (value) {
            if (value.isNotEmpty) {
              setState(() {
                descText = value;
              });
              return null;
            } else if (value.isEmpty) {
              return "This field can't be left empty";
            } else {
              return "Description is Invalid";
            }
          },
          maxLines: null,
          decoration: InputDecoration(
              labelText: "DESCRIPTION", labelStyle: TextStyle(fontSize: 13))),
    );
  }

  Future<String> uploadImage() async {
    StorageReference ref = _storage
        .ref()
        .child('foodPlan')
        .child("thumb_${DateTime.now().millisecondsSinceEpoch}.jpg");

    StorageUploadTask uploadTask = ref.putFile(image);

    var downloadUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

    return downloadUrl.toString();
  }

  getImage() async {
    try {
      var testFile = await ImagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 69);
      if (testFile != null)
        setState(() {
          image = testFile;
        });
    } catch (e) {
      print(e.toString());
    }
  }

  addFoodPlan() async {
    String imageUrl;
    try {
      if (_formKey.currentState.validate() && userModel != null) {
        setState(() {
          isLoading = true;
        });

        if (image != null) {
          imageUrl = await uploadImage();
        }
        List<FoodData> data = [];

        for (var i = 0; i < 7; i++) {
          FoodData foodData = new FoodData(day: '', content: []);

          foodData.day = i == 0
              ? 'Monday'
              : i == 1
                  ? 'Tuesday'
                  : i == 2
                      ? 'Wednesday'
                      : i == 3
                          ? 'Thursday'
                          : i == 4
                              ? 'Friday'
                              : i == 5 ? 'Saturday' : i == 6 ? 'Sunday' : '';
          foodData.content
              .add(Content(type: 'BreakFast', desc: breakfastList[i]));
          foodData.content.add(Content(type: 'Lunch', desc: lunchList[i]));
          foodData.content.add(Content(type: 'Dinner', desc: dinnerList[i]));

          if (foodData != null && foodData?.day != '') data.add(foodData);
        }

        foodDataModel = new FoodDataModel(
          data: data,
          timeStamp: DateTime.now(),
          desc: descText,
          imageUrl: imageUrl,
          name: userModel.userName,
          photoUrl: userModel.userPhotoUrl,
          title: titleText,
          userId: userModel.userId,
        );

        print(foodDataModel.toJson());

        final reference =
            FirebaseDatabase.instance.reference().child('foodPlan');
        print(foodDataModel.toJson());
        reference.push().set(foodDataModel.toJson()).then((value) async {
          setState(() {
            isLoading = false;
          });
          Navigator.pop(context);
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }
}
