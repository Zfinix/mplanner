import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bmnav/bmnav.dart' as bmnav;
import 'package:mplanner/healthCal/main.dart';
import 'package:mplanner/utils/colors.dart';
import 'package:mplanner/views/chat/views/ChatScreen.dart';
import 'package:mplanner/views/chat/views/ChooseUserScreen.dart';
import 'package:mplanner/views/home/fragments/chatFrag.dart';
import 'package:mplanner/views/home/fragments/homeFrag.dart';

class Controller extends StatefulWidget {
  final FirebaseUser user;

  const Controller({Key key, @required this.user}) : super(key: key);

  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  int currentTab = 1;
  List<Widget> screens;
  Widget currentScreen;

  @override
  void initState() {
    _setController();
    super.initState();
  }

  _setController() {
    setState(() {
      screens = [
        ChatScreen(
          signedInUser: widget.user,
          userName: widget.user.displayName,
        ),
        HomeFragment(),
        FitnessDashboard(),
      ];
      currentScreen = HomeFragment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNav(),
      body: currentScreen,
    );
  }

  _buildBottomNav() {
    return bmnav.BottomNav(
      iconStyle: bmnav.IconStyle(onSelectColor: accentColor),
      items: [
        bmnav.BottomNavItem(Icons.chat_bubble, label: 'Chat'),
        bmnav.BottomNavItem(Icons.home, label: 'Home'),
        bmnav.BottomNavItem(Icons.fitness_center, label: 'Health Calculators'),
      ],
      index: currentTab,
      labelStyle: bmnav.LabelStyle(
        visible: false,
      ),
      onTap: (i) {
        setState(() {
          currentTab = i;
          currentScreen = screens[i];
        });
      },
    );
  }
}
