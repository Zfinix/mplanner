import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatMessageListItem extends StatelessWidget {
  final DataSnapshot messageSnapshot;
  final Animation animation;
  final String userName;

  final currentUserEmail;

  ChatMessageListItem(
      {this.messageSnapshot,
      this.animation,
      @required this.currentUserEmail,
      this.userName});

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
      sizeFactor:
          new CurvedAnimation(parent: animation, curve: Curves.decelerate),
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
          children: currentUserEmail == messageSnapshot.value['email'] ||
                  userName == messageSnapshot.value['senderName']
              ? getSentMessageLayout()
              : getReceivedMessageLayout(),
        ),
      ),
    );
  }

  List<Widget> getSentMessageLayout() {
    //print("Image:" + messageSnapshot.value['imageUrl']);

    return <Widget>[
      new Expanded(
        child: Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new Text('You',
                  style: new TextStyle(
                      fontSize: 11.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              new Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: messageSnapshot.value['imageUrl'] != null
                      ? new ClipRRect(
                          borderRadius: new BorderRadius.circular(18.0),
                          child: new FadeInImage.assetNetwork(
                        placeholder: 'assets/images/hkloader.gif',
                        width: 250,
                        image: messageSnapshot.value['imageUrl'],
                      ))
                      : new Text(messageSnapshot.value['text'],
                          style: new TextStyle(
                              fontSize: 15.0, color: Colors.white)))
            ],
          ),
        ),
      ),
      new Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          new Container(
              margin: const EdgeInsets.only(left: 8.0),
              child: new CircleAvatar(
                backgroundImage: new NetworkImage("https://bit.ly/2BCsKbI"),
              )),
        ],
      ),
    ];
  }

  List<Widget> getReceivedMessageLayout() {
    //print("Image:" + messageSnapshot.value['imageUrl']);
    return <Widget>[
      new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: new CircleAvatar(
                backgroundImage: new NetworkImage("https://bit.ly/2BCsKbI"),
              )),
        ],
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(messageSnapshot.value['senderName'],
                style: new TextStyle(
                    fontSize: 11.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: messageSnapshot.value['imageUrl'] != null
                  ? ClipRRect(
                      borderRadius: new BorderRadius.circular(18.0),
                      child: new FadeInImage.assetNetwork(
                        placeholder: 'assets/images/hkloader.gif',
                        width: 250,
                        image: messageSnapshot.value['imageUrl'],
                      ))
                  : new Text(messageSnapshot.value['text'],
                      style:
                          new TextStyle(fontSize: 15.0, color: Colors.black)),
            ),
          ],
        ),
      ),
    ];
  }
}
