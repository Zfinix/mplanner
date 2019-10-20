import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mplanner/models/userModel.dart';

abstract class BaseAuth {
  String profileNode;
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<FirebaseUser> getCurrentUser();
  Future<UserModel> getCurrentUserData({userId});
  Future<void> signOut(context);
  Future<void> resetPassword(email, context);
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String profileNode;

  Future<String> signIn(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<UserModel> getCurrentUserData({userId}) async {
    FirebaseUser user = await _firebaseAuth.currentUser();

    var v = (await FirebaseDatabase.instance
        .reference()
        .child('users')
        .orderByChild('userId')
        .equalTo(userId ?? user.uid)
        .once());

    if (v.value != null) {
      profileNode = v.value.keys.toList()[0];
      return UserModel.fromMap(v.value.values.toList()[0]);
    }

    return null;
  }

  Future<void> signOut(context) async {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Password Reset"),
              content: new Text("Password Reset Email Sent"),
            ));
    return _firebaseAuth.signOut();
  }

  Future<void> resetPassword(email, context) async {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Password Reset"),
              content: new Text("Password Reset Email Sent"),
            ));

    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
