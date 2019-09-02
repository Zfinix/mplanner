import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:firebase_database/firebase_database.dart';

bool isLoadingSearch;

class ChatUserConfig {
  static Future<String> runC(userId1, userId2) async {
    String chatId = '$userId1$userId2';
    String rvChatId = '$userId2$userId1';

    var snapshot1 = await FirebaseDatabase.instance
        .reference()
        .child('messages')
        .child(chatId)
        .once();
    var result = snapshot1.value;
    // print(result);

    var snapshot2 = await FirebaseDatabase.instance
        .reference()
        .child('messages')
        .child(rvChatId)
        .once();
    var result2 = snapshot2.value;
    // print(result2);

    if (result != null) {
      return chatId;
    } else if (result2 != null) {
      return rvChatId;
    } else {
      return chatId;
    }
  }

  static Future<bool> checkChat(userId1, userId2) async {
    var snapshot1 = await FirebaseDatabase.instance
        .reference()
        .child('messages')
        .once();
    var result = snapshot1.value;
  
     print(result);

    if (result) {
      return false;
    } else {
      return true;
    }
  }

  static Future<String> botChat(userId1) async {
    String chatId = 'BOT-$userId1';

    var snapshot1 = await FirebaseDatabase.instance
        .reference()
        .child('botMessages')
        .child(chatId)
        .once();

   // var result = snapshot1.value;
    // print(result);

    return chatId;
  }

  static Future<List<String>> checkChatByPhone(phone, context) async {
    isLoadingSearch = true;
    List<String> list = [];
    var snapshot1;
    try {
      snapshot1 =
          await FirebaseDatabase.instance.reference().child('users').once();

 
      // rest of code
    } on TimeoutException catch (_) {
     /*  showDialog(
          context: context,
          builder: (_) => AssetGiffyDialog(
                imagePath: 'assets/images/networkerror.gif',
                title: Text(
                  'Opps',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                ),
                description: Text(
                  "Couldn't Find Contact on HealtKonnet",
                  textAlign: TextAlign.center,
                  style: TextStyle(),
                ),
                onOkButtonPressed: () {},
              ),
        );
      // A timeout occurred.
     */}

    var result = snapshot1.value;

    Map<dynamic, dynamic> fridgesDs = result;
    fridgesDs.forEach((key, value) {
      if (value['phone'] == phone) {
        list.add(value['userId']);
        list.add(value['userName']);
        //print(value['userId']);

        return list;
      } else {
        print(isLoadingSearch);
       
        isLoadingSearch = false;
        return null;
      }
    });
    return list;
  }
}
