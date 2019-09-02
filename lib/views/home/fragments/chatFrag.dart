import 'package:flutter/material.dart';

class ChatFragment extends StatefulWidget {
  _ChatFragmentState createState() => _ChatFragmentState();
}

class _ChatFragmentState extends State<ChatFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('Chat')
       )
    );
  }
}