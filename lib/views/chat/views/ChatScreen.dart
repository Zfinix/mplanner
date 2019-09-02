import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mplanner/views/auth/loginPage.dart';
import 'package:mplanner/views/chat/auth/baseAuth.dart';
import 'package:mplanner/views/chat/widgets/ChatMessageListItem.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final auth = FirebaseAuth.instance;
var currentUserEmail;
var _scaffoldContext;

class ChatScreen extends StatefulWidget {
  final String userName;
  final FirebaseUser signedInUser;

  const ChatScreen(
      {Key key, @required this.userName, @required this.signedInUser})
      : super(key: key);

  @override
  ChatScreenState createState() {
    return new ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> {
  final BaseAuth auth = new Auth();

  var reference = FirebaseDatabase.instance
      .reference()
      .child('messages')
      .child("B33@B8yb7vt79v75vt77431dH@&7");

  final TextEditingController _textEditingController =
      new TextEditingController();
  bool _isComposingMessage = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          flexibleSpace: _buildTitle(),
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
          /* actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.exit_to_app), onPressed: _signOut)
          ], */
        ),
        body: new Container(
            child: new Column(
              children: <Widget>[
                new Flexible(
                  child: new FirebaseAnimatedList(
                    query: reference,
                    padding: const EdgeInsets.all(8.0),
                    reverse: true,
                    sort: (a, b) => b.key.compareTo(a.key),
                    //comparing timestamp of messages to check which one would appear first
                    itemBuilder: (_, DataSnapshot messageSnapshot,
                        Animation<double> animation, x) {
                      return new ChatMessageListItem(
                        messageSnapshot: messageSnapshot,
                        animation: animation,
                        currentUserEmail: currentUserEmail,
                      );
                    },
                  ),
                ),
                _isLoading
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator()),
                      )
                    : Container(),
                new Divider(height: 1.0),
                new Container(
                  decoration:
                      new BoxDecoration(color: Theme.of(context).cardColor),
                  child: _buildTextComposer(),
                ),
                new Builder(builder: (BuildContext context) {
                  _scaffoldContext = context;
                  return new Container(width: 0.0, height: 0.0);
                })
              ],
            ),
           ));
  }

  CupertinoButton getIOSSendButton() {
    return new CupertinoButton(
      child: new Text("Send"),
      onPressed: _isComposingMessage
          ? () => _textMessageSubmitted(_textEditingController.text)
          : null,
    );
  }

  IconButton getDefaultSendButton() {
    return new IconButton(
      icon: new Icon(Icons.send),
      onPressed: _isComposingMessage
          ? () => _textMessageSubmitted(_textEditingController.text)
          : null,
    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(
          color: _isComposingMessage
              ? Theme.of(context).accentColor
              : Theme.of(context).disabledColor,
        ),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                    icon: new Icon(
                      Icons.photo_camera,
                      color: Theme.of(context).accentColor,
                    ),
                    onPressed: () async {
                      /* await _ensureLoggedIn();
                      setState(() {
                        _isLoading = true;
                      });
                      File imageFile = await ImagePicker.pickImage(
                          source: ImageSource.gallery);
                      int timestamp = new DateTime.now().millisecondsSinceEpoch;
                      StorageReference storageReference = FirebaseStorage
                          .instance
                          .ref()
                          .child("img_" + timestamp.toString() + ".jpg");
                      StorageUploadTask uploadTask =
                          storageReference.putFile(imageFile);

                      StorageTaskSnapshot storageTaskSnapshot =
                          await uploadTask.onComplete;

                      var downloadUrl =
                          await storageTaskSnapshot.ref.getDownloadURL();
                      print(downloadUrl);

                      _sendMessage(
                          messageText: null, imageUrl: downloadUrl.toString());
                      setState(() {
                        _isLoading = false;
                      }); */
                    }),
              ),
              new Flexible(
                child: new TextField(
                  controller: _textEditingController,
                  onChanged: (String messageText) {
                    setState(() {
                      _isComposingMessage = messageText.length > 0;
                    });
                  },
                  onSubmitted: _textMessageSubmitted,
                  decoration:
                      new InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              new Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? getIOSSendButton()
                    : getDefaultSendButton(),
              ),
            ],
          ),
        ));
  }

  Future<Null> _textMessageSubmitted(String text) async {
    _textEditingController.clear();

    setState(() {
      _isComposingMessage = false;
    });

    await _ensureLoggedIn();
    _sendMessage(messageText: text, imageUrl: null);
  }

  void _sendMessage({String messageText, String imageUrl}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    reference.push().set({
      'text': messageText,
      'email': widget.signedInUser.email,
      'imageUrl': imageUrl,
      'senderName': widget.userName,
      'senderPhotoUrl': widget.signedInUser.photoUrl,
    });
  }

  Future<Null> _ensureLoggedIn() async {
    currentUserEmail = widget.signedInUser.email;

    if (await auth.getCurrentUser() == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

  _buildTitle() {
    return AppBar(
      title: Text('Forum',
          style: TextStyle(
              //color: Colors.yellow,
              fontSize: 19,
              fontWeight: FontWeight.bold)),
    );
  }
  /*  Future _signOut() async {
    await auth.signOut(context);
    Scaffold.of(_scaffoldContext)
        .showSnackBar(new SnackBar(content: new Text('User logged out')));

    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  } */
}
