import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String name, imageUrl, profilePicUrl, desc, title;
  final DateTime timeStamp;
  const RecipeCard(
      {Key key,
      this.name,
      this.imageUrl,
      this.desc,
      this.title,
        this.profilePicUrl,
      this.timeStamp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  flex: 6,
                  child: MPAvatar(
                    name: name ?? '',

                  ),
                ),
                Flexible(
                  flex: 1,
                  child: IconButton(icon: Icon(Icons.share), onPressed: () {}),
                ),
              ],
            ),
            imageUrl != null
                ? Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(imageUrl))),
                  )
                : Container(),
            Container(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                title ?? '',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MPAvatar extends StatelessWidget {
  final name;
  final url;
  const MPAvatar({Key key, this.name, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        title: Text(name ?? 'Anonymous'),
        leading: new CircleAvatar(
          backgroundImage: new NetworkImage(url ?? "https://bit.ly/2BCsKbI"),
        ),
      ),
    );
  }
}
