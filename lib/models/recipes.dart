import 'package:firebase_database/firebase_database.dart';

class Recipes {
  String title;
  String imageUrl;
  String profilePicUrl;
  String description;
  String name;
  String userID;
  DateTime timestamp;
  final String key;

  Recipes(this.title, this.timestamp, this.imageUrl,this.profilePicUrl, this.description,
      this.name, {this.key});

  Recipes.fromMap( Map<dynamic, dynamic> map, {this.key})
      : assert(map['title'] != null),
        assert(map['name'] != null),
        title = map['title'],
        imageUrl = map['imageUrl'],
        profilePicUrl = map['profilePicUrl'],
        description = map['description'],
        name = map['name'],
        userID = map['userID'],
        timestamp = map['timestamp'].isEmpty ? DateTime.now() :DateTime.parse(map['dateTime']);

  Recipes.fromSnapshot(DataSnapshot snapshot)
      : this.fromMap(snapshot.value, key: snapshot.key);

   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['imageUrl'] = this.imageUrl;
    data['profilePicUrl'] = this.profilePicUrl;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['userID'] = this.userID;
    data['name'] = this.name;
    data['timestamp'] = this.timestamp.toIso8601String();
    return data;
  }
}
