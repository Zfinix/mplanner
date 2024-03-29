import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mplanner/models/recipes.dart';
import 'package:mplanner/models/userModel.dart';
import 'package:mplanner/utils/margin.dart';
import 'package:mplanner/views/auth/baseAuth.dart';

class AddRecipe extends StatefulWidget {
  AddRecipe({
    Key key,
  }) : super(key: key);

  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  Recipes recipe;
  File image;
  FirebaseStorage _storage = FirebaseStorage.instance;
  String titleText, descText;
  bool isLoading = false;
  UserModel userModel;

  final _formKey = GlobalKey<FormState>();
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
        title: Text('Add a Recipe'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            yMargin50,
            buildImage(),
            yMargin40,
            title(),
            yMargin40,
            desc(),
            yMargin100,
            Column(
              children: <Widget>[
                !isLoading
                    ? Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: FlatButton(
                            child: Text(
                              'UPLOAD RECIPE',
                              style: TextStyle(fontSize: 14),
                            ),
                            color: Colors.green,
                            textColor: Colors.white,
                            onPressed: () => addRecipe()),
                      )
                    : Container(
                        height: 45,
                        width: 45,
                        child: CircularProgressIndicator(),
                      ),
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
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  new BoxShadow(
                    offset: Offset(6, 20),
                    spreadRadius: -17,
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 14,
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
        .child('recipes')
        .child("thumb_${DateTime.now().millisecondsSinceEpoch}.jpg");

    StorageUploadTask uploadTask = ref.putFile(image);

    var downloadUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

    return downloadUrl.toString();
  }

  getImage() async {
    try {
      await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 69)
          .then((img) {
        if (img != null) {
          setState(() {
            image = img;
          });
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  addRecipe() async {
    String imageUrl;
    try {
      if (_formKey.currentState.validate() && userModel != null) {
        setState(() {
          isLoading = true;
        });

        if (image != null) {
          imageUrl = await uploadImage();
        }

        setState(() {
          recipe = new Recipes(
              titleText,
              DateTime.now(),
              imageUrl,
              userModel.userId,
              userModel?.userPhotoUrl ?? '',
              descText,
              userModel?.userName ?? 'Anonymous');
        });

        final reference =
            FirebaseDatabase.instance.reference().child('recipes');
        print(recipe.toJson());
        reference.push().set(recipe.toJson()).then((value) async {
          setState(() {
            isLoading = false;
          });
        });
        Navigator.pop(context);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
