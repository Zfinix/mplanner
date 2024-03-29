import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mplanner/models/userModel.dart';
import 'package:mplanner/utils/margin.dart';

class ProfilePage extends StatefulWidget {
  UserModel userModel;
  final String profileNode;

  ProfilePage({Key key, @required this.userModel, @required this.profileNode})
      : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File image;
  FirebaseStorage _storage = FirebaseStorage.instance;
  String name, bioText, photoUrl;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userModel.userPhotoUrl);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(children: <Widget>[
          customYMargin(40),
          Column(
            children: <Widget>[
              GestureDetector(
                  onTap: () => getImage(),
                  child: Container(
                      height: 156,
                      width: 156,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(220),
                        ),
                        child: Icon(Icons.camera_alt, size: 50),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(220),
                        color: Colors.white,
                        boxShadow: [
                          new BoxShadow(
                            offset: Offset(6, 20),
                            spreadRadius: -17,
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 14,
                          ),
                        ],
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                widget?.userModel?.userPhotoUrl != null &&
                                        widget.userModel.userPhotoUrl.isNotEmpty
                                    ? widget.userModel.userPhotoUrl
                                    : 'https://bit.ly/2BCsKbI')),
                      ))),
            ],
          ),
          customYMargin(40),
          nameField(),
          customYMargin(40),
          emailField(),
          customYMargin(40),
          bioField(),
          customYMargin(60),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              !isLoading
                  ? Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: FlatButton(
                          child: Text(
                            'UPDATE PROFILE',
                            style: TextStyle(fontSize: 14),
                          ),
                          color: Colors.green,
                          textColor: Colors.white,
                          onPressed: () => addRecipe()),
                    )
                  : Container(
                      height: 45,
                      width: 45,
                      child: Column(
                        children: <Widget>[CircularProgressIndicator()],
                      ),
                    ),
            ],
          )
        ]),
      ),
    );
  }

  nameField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
          initialValue: widget?.userModel?.userName,
          validator: (value) {
            if (value.isNotEmpty) {
              setState(() {
                name = value;
              });
              return null;
            } else if (value.isEmpty) {
              return "This field can't be left empty";
            } else {
              return "Field is Invalid";
            }
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              labelText: "NAME",
              labelStyle: TextStyle(fontSize: 13))),
    );
  }

  emailField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
          initialValue: widget.userModel?.email ?? '',
          enabled: false,
          validator: (value) {
            if (value.isNotEmpty) {
              setState(() {
                name = value;
              });
              return null;
            } else if (value.isEmpty) {
              return "This field can't be left empty";
            } else {
              return "Field is Invalid";
            }
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              labelText: "Email",
              labelStyle: TextStyle(fontSize: 13))),
    );
  }

  bioField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
          initialValue: widget.userModel?.bio ?? '',
          validator: (value) {
            if (value.isNotEmpty) {
              setState(() {
                bioText = value;
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
              labelText: "BIO", labelStyle: TextStyle(fontSize: 13))),
    );
  }

  Future<String> uploadPhoto() async {
    StorageReference ref = _storage
        .ref()
        .child('profilePics')
        .child("thumb_${widget.userModel.userId}.jpg");
    StorageUploadTask uploadTask = ref.putFile(image);

    var downloadUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

    return downloadUrl.toString();
  }

  getImage() async {
    try {
      var testFile = await ImagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 79);
      setState(() {
        image = testFile;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  addRecipe() async {
    try {
      var userModel;

      if (_formKey.currentState.validate()) {
        setState(() {
          isLoading = true;
        });

        if (image != null) {
          photoUrl = await uploadPhoto();
        }

        setState(() {
          userModel = new UserModel(widget.userModel.email, photoUrl ?? '',
              bioText, widget.userModel.userId, widget?.userModel?.userName);
        });

        FirebaseDatabase.instance
            .reference()
            .child('users')
            .child(widget.profileNode)
            .update(userModel.toJson())
            .then((value) async {
          setState(() {
            isLoading = false;
          });
          Navigator.pop(context);
        });
      } else {
        throw 'An Error Occurred';
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }
}
