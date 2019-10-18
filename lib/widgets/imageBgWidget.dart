import 'package:flutter/material.dart';

class ImageBGScaffold extends StatefulWidget {
  final Widget child;
  final String bg;

  ImageBGScaffold({Key key, @required this.child, @required this.bg}) : super(key: key);
  _ImageBGScaffoldState createState() => _ImageBGScaffoldState();
}

class _ImageBGScaffoldState extends State<ImageBGScaffold> {
  @override
  Widget build(BuildContext context) {
    return new Material(
        type: MaterialType.transparency,
        child: Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                  image: new AssetImage("assets/images/${widget.bg}.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
             widget.child,
          ],
        ));
  }
}
