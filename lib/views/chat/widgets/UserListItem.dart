import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserListItem extends StatefulWidget {
  final DataSnapshot usersSnapshot;
  final userId;

  final Animation animation;
  final String name;
  final String currentUserEmail;

  UserListItem(
      {this.usersSnapshot,
      this.animation,
      @required this.currentUserEmail,
      this.name,
      this.userId});

  @override
  _UserListItemState createState() => _UserListItemState();
}

class _UserListItemState extends State<UserListItem> {
  SharedPreferences prefs;
  List<String> list;

  @override
  void initState() {
    _loadPref();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(list.contains('${widget.userId}'));
   /*  if (list != null && list.contains('${widget.userId}')) { */
      return new SizeTransition(
        sizeFactor: new CurvedAnimation(
            parent: widget.animation, curve: Curves.decelerate),
        child: new Container(
          decoration: new BoxDecoration(
            color: Colors.white,
            border: new Border.all(width: 0.3, color: Colors.white),
            borderRadius: new BorderRadius.circular(45.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: getUserLayout(),
        ),
      );
   /*  } else {
      return new Container(
          //child: Image.asset('assets/images/')
          );
    } */
  }

  getUserLayout() {
    print(widget.usersSnapshot.value);
   /*  if (widget.usersSnapshot.value['email'] == widget.currentUserEmail) {}
    */ return /* widget.usersSnapshot.value != null &&
            widget.usersSnapshot.value['email'] != widget.currentUserEmail
        /* &&  usersSnapshot.value['userType'] != 'user' */
        ?  */ListTile(
            leading: new CircleAvatar(
              backgroundImage: new NetworkImage("https://bit.ly/2BCsKbI"),
            ),
            title: new Text(widget.usersSnapshot.value['userName'],
                style: new TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)))
       /*  : Container() */;
  }

  _loadPref() async {
    prefs = await SharedPreferences.getInstance();
    //print(list);
    if (prefs.getStringList('chatList') != null) {
      setState(() {
        list = prefs.getStringList('chatList');
      });
     // print(list);
    }
  }
}
