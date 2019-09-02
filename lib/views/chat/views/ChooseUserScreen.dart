import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mplanner/views/chat/auth/baseAuth.dart';
import 'package:mplanner/views/chat/util/chatUserConfig.dart';
import 'package:mplanner/views/chat/views/ChatScreen.dart';
import 'package:mplanner/views/chat/widgets/UserListItem.dart';
import 'package:mplanner/utils/margin.dart';

final auth = FirebaseAuth.instance;
var currentUserEmail;
var _scaffoldContext;

class ChooseScreen extends StatefulWidget {
  final String userId;
  final FirebaseUser signedInUser;

  ChooseScreen({Key key, @required this.userId, @required this.signedInUser})
      : super(key: key);

  @override
  ChooseScreenState createState() {
    return new ChooseScreenState();
  }
}

class ChooseScreenState extends State<ChooseScreen> {
  final BaseAuth auth = new Auth();
  var reference = FirebaseDatabase.instance.reference().child('users');
  String secondUserId;
  DataSnapshot snapshotData;
  String _username;

  @override
  void initState() {
    super.initState();
    FirebaseDatabase database;
    database = FirebaseDatabase.instance;
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      /* appBar: new AppBar(
        title: new Text("mplanner/healthCal/views Chat"),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.exit_to_app), onPressed: _signOut)
        ],
      ), */
      body: new Container(
        child: new Column(
          children: <Widget>[
            _buildTitle(),
            new Flexible(
              child: new FirebaseAnimatedList(
                query: reference,
                padding: const EdgeInsets.all(8.0),
                reverse: false,
                sort: (a, b) => b.key.compareTo(a.key),
                //comparing timestamp of messages to check which one would appear first
                itemBuilder:
                    (_, DataSnapshot data, Animation<double> animation, x) {
                  var name;
                  currentUserEmail = widget.signedInUser.email;
                  return InkWell(
                    onTap: () {
                      if (data.value['userId'] != null) {
                        setId(data.value['userId'], data.value['userName']);
                        print(data.value);
                        setState(() {
                          _username = data.value['userName'];
                        });
                      }
                    },
                    child: new UserListItem(
                      usersSnapshot: data,
                      name: name,
                      animation: animation,
                      currentUserEmail: currentUserEmail,
                      userId: data.value['userId'],
                    ),
                  );
                },
              ),
            )
          ],
        ),
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? new BoxDecoration(
                border: new Border(
                    top: new BorderSide(
                color: Colors.grey[200],
              )))
            : null,
      ),
      floatingActionButton: _buildFab(),
    );
  }

  _buildTitle() {
    return Column(
      children: <Widget>[
        customYMargin(60),
        Row(
          children: <Widget>[
            customXMargin(20),
            Text('Chat',
                style: TextStyle(
                    color: Colors.black,
                    //color: Colors.yellow,
                    fontSize: 19,
                    fontWeight: FontWeight.bold))
          ],
        ),
        customYMargin(2),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
              height: 2,
              width: 20,
              margin: EdgeInsets.only(right: 300),
              color: Colors.yellow),
        ),
        customYMargin(13),
      ],
    );
  }

  Future _signOut() async {
    await auth.signOut(context);
    Scaffold.of(_scaffoldContext)
        .showSnackBar(new SnackBar(content: new Text('User logged out')));
  }

  _buildFab() {
    return FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        onPressed: () {
          /*  Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SelectChatByPhone(
                      signedInUser: widget.signedInUser,
                      userName: _username,
                    )),
          ); */
        },
        child: Icon(
          Icons.chat_bubble,
          color: Colors.white,
        ));
  }

  setId(userId2, username) async {
    //  print("USERNAME: $_username");
    var chatId = await ChatUserConfig.runC(widget.userId, userId2);

    if (chatId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(
                signedInUser: widget.signedInUser,
                userName: _username,
              ),
        ),
      );
    }
  }
}
