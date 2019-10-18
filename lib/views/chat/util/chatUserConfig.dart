import 'dart:async';

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

}
