import 'package:flutter/material.dart';

class ImageBGScaffold extends StatefulWidget {
  final Widget child;
  final String bg;
  final bool isFromNetwork;

  ImageBGScaffold(
      {Key key,
      @required this.child,
      @required this.bg,
      this.isFromNetwork = false})
      : super(key: key);
  _ImageBGScaffoldState createState() => _ImageBGScaffoldState();
}

class _ImageBGScaffoldState extends State<ImageBGScaffold> {
  @override
  Widget build(BuildContext context) {
    return !widget.isFromNetwork
        ? new Material(
            type: MaterialType.transparency,
            child: Stack(
              children: <Widget>[
                new Container(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.dstATop),
                      image: AssetImage("assets/images/${widget.bg}.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                widget.child,
              ],
            ))
        : Scaffold(
            appBar: AppBar(
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: new Container(
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.dstATop),
                        image: NetworkImage(widget.bg),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
