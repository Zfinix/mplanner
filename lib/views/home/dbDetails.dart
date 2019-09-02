import 'package:flutter/material.dart';

import 'fragments/homeFrag.dart';

class DBDetails extends StatelessWidget {
  final DBItem dbItem;
  const DBDetails({Key key, @required this.dbItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[700],
                image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.6), BlendMode.multiply),
                    image: AssetImage('assets/images/${dbItem?.image}.jpg')),
              ),
              child: Center(
                child: Text(dbItem?.title ?? 'LOREM IPSUM',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 21,
                        color: Colors.white,
                        fontWeight: FontWeight.w500)),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: ListView(
          children: <Widget>[
            Text(dbItem?.desc ?? 'lOREM Ipsum dor esit',
                softWrap: true,
                style: TextStyle(
                    fontSize: 18,
                    height: 1.4,
                    color: Colors.white,
                    fontWeight: FontWeight.w300))
          ],
        ),
      ),
    );
  }
}
