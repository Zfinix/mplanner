import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mplanner/views/auth/loginPage.dart';
import 'package:mplanner/views/chat/auth/baseAuth.dart';
import 'package:mplanner/views/chat/util/Themes.dart';
import 'package:mplanner/views/chat/views/ChooseUserScreen.dart';

class FlutterChatApp extends StatefulWidget {
  @override
  FlutterChatAppState createState() {
    return new FlutterChatAppState();
  }
}

class FlutterChatAppState extends State<FlutterChatApp> {
  FirebaseUser user;
  String userId;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  final BaseAuth auth = new Auth();
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "mplanner/healthCal/views",
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? Themes.kIOSTheme
          : Themes.kDefaultTheme,
      home: user != null && userId != null
          ? ChooseScreen(userId: userId, signedInUser: user)
          : new LoginPage(),
    );
  }

  

  void getCurrentUser() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    user = await _firebaseAuth.currentUser();

    if (user != null) {
      print(user.uid);
      setState(() {
        userId = user.uid;
      });

    }
  }
}
