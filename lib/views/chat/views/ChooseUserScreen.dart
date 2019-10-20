import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mplanner/views/auth/baseAuth.dart';
import 'package:mplanner/views/chat/util/chatUserConfig.dart';
import 'package:mplanner/views/chat/views/ChatScreen.dart';
import 'package:mplanner/views/chat/widgets/UserListItem.dart';

final auth = FirebaseAuth.instance;
var currentUserEmail;

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
      appBar: new AppBar(
        title: new Text("Chat"),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Flexible(
              child: new FirebaseAnimatedList(
                query: reference,
                padding: const EdgeInsets.only(top: 18.0),
                reverse: false,
                sort: (a, b) => b.key.compareTo(a.key),
                itemBuilder:
                    (_, DataSnapshot data, Animation<double> animation, x) {
                  var name;
                  currentUserEmail = widget.signedInUser.email;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: data.value['email'] == currentUserEmail
                        ? Container()
                        : InkWell(
                            onTap: () {
                              if (data.value['userId'] != null) {
                                setId(data.value['userId'],
                                    data.value['userName']);

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
    );
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
            reference: FirebaseDatabase.instance
                .reference()
                .child('messages')
                .child(chatId),
            recieverId: userId2,
          ),
        ),
      );
    }
  }
}
