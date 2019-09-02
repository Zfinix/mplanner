import 'package:flutter/material.dart';
import 'package:mplanner/utils/db.dart';
import 'package:mplanner/utils/margin.dart';

import '../dbDetails.dart';

class HomeFragment extends StatefulWidget {
  final Widget child;

  HomeFragment({Key key, this.child}) : super(key: key);

  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 40),
            child: Text(
              'DIABETES TIPS',
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
            ),
          ),
          DBTips(),
         // CalendarDB(),
        ],
      ),
    );
  }
}
class CalendarDB extends StatelessWidget {
  const CalendarDB({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      height: MediaQuery.of(context).size.height * 0.74,
      width: MediaQuery.of(context).size.width,
      child:  ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dbitems?.length ?? 0,
        itemBuilder: (BuildContext context, int i) {
         // return DBCard(dbItem: dbitems[i]);
        },
      ),
    );
    
  }}

class DBTips extends StatelessWidget {
  const DBTips({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.36,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dbitems?.length ?? 0,
        itemBuilder: (BuildContext context, int i) {
          return DBCard(dbItem: dbitems[i]);
        },
      ),
    );
  }
}

class DBCard extends StatelessWidget {
  final DBItem dbItem;
  const DBCard({Key key, this.dbItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[700],
        image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.multiply),
            image: AssetImage('assets/images/${dbItem?.image}.jpg')),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => DBDetails(dbItem: dbItem),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(dbItem?.title ?? 'LOREM IPSUM',
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
            customYMargin(13),
            Text(dbItem?.desc ?? 'lOREM Ipsum dor esit',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 13,
                    height: 1.3,
                    color: Colors.white,
                    fontWeight: FontWeight.w300)),
          ],
        ),
      ),
    );
  }
}

class DBItem {
  final title, desc, image;

  DBItem({@required this.title, @required this.desc, @required this.image});
}
