import 'package:firebase_database/firebase_database.dart';

class UserModel {
  String email;
  String userPhotoUrl;
  String bio;
  String userName;
  final String key;

  UserModel(this.email, this.userPhotoUrl, this.bio, this.userName, {this.key});

  UserModel.fromMap(Map<dynamic, dynamic> map, {this.key})
      : email = map['email'],
        userPhotoUrl = map['userPhotoUrl'],
        bio = map['bio'],
        userName = map['userName'];

  UserModel.fromSnapshot(DataSnapshot snapshot)
      : this.fromMap(snapshot.value, key: snapshot.key);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['userPhotoUrl'] = this.userPhotoUrl;
    data['bio'] = this.bio;
    data['userName'] = this.userName;
    return data;
  }
}
