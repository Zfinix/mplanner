import 'package:flutter/material.dart';

errorHandler(error, BuildContext context) {
    if (error.body != null) {
      String msg = error.data.toString();
      print(error.data);

      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text('Error ${'error.statusCode'}'),
                content: new Text(msg),
              ));
    }
  }