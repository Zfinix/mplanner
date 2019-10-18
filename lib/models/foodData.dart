import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FoodDataModel {
  String name, title, photoUrl, imageUrl, desc, userId;
  List<FoodData> data = [];
  DateTime timeStamp;
  final key;

  FoodDataModel({
    @required this.data,
    @required this.name,
    @required this.userId,
    @required this.title,
    @required this.desc,
    @required this.imageUrl,
    @required this.timeStamp,
    this.photoUrl,
    this.key,
  });

  FoodDataModel.fromJson(Map<String, dynamic> json, {this.key}) {
    name = json['name'];
    title = json['title'];
    desc = json['desc'];
    userId = json['userId'];
    photoUrl = json['photoUrl'];
    imageUrl = json['imageUrl'];
    if (json['data'] != null) {
      data = new List<FoodData>();
      json['data'].forEach((v) {
        data.add(new FoodData.fromJson(v));
      });
    }

    timeStamp = json['timestamp'] == null || json['timestamp'].isEmpty
        ? DateTime.now()
        : DateTime.parse(json['timestamp']);
  }

  FoodDataModel.fromMap(Map<dynamic, dynamic> map, {this.key}) {
    name = map['name'];
    title = map['title'];
    desc = map['desc'];
    userId = map['userId'];
    photoUrl = map['photoUrl'];
    imageUrl = map['imageUrl'];

    if (map['data'] != null) {
      map['data'].forEach((v) {
        data.add(new FoodData.fromMap(v));
      });
    }

    timeStamp = map['timestamp'] != null
        ? DateTime.parse(map['timestamp'].toString())
        : DateTime.now() ;
  }

  FoodDataModel.fromSnapshot(DataSnapshot snapshot)
      : this.fromMap(snapshot.value, key: snapshot.key);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['title'] = title;
    data['desc'] = desc;
    data['userId'] = userId;
    data['photoUrl'] = photoUrl;
    data['imageUrl'] = imageUrl;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['timestamp'] = this.timeStamp.toIso8601String();
    return data;
  }
}

class FoodData {
  String day;
  List<Content> content = [];
  final key;

  FoodData({this.day, this.content, this.key});

  FoodData.fromJson(Map<String, dynamic> json, {this.key}) {
    day = json['day'];
    if (json['content'] != null) {
      content = new List<Content>();
      json['content'].forEach((v) {
        content.add(new Content.fromJson(v));
      });
    }
  }

  FoodData.fromMap(Map<dynamic, dynamic> map, {this.key}) {
    day = map['day'];
    if (map['content'] != null) {
      map['content'].forEach((v) {
        content.add(new Content.fromMap(v));
      });
    }
  }

  FoodData.fromSnapshot(DataSnapshot snapshot)
      : this.fromMap(snapshot.value, key: snapshot.key);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    if (this.content != null) {
      data['content'] = this.content.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Content {
  String type;
  String desc;
  final String key;

  Content({this.type, this.desc, this.key});

  Content.fromJson(Map<String, dynamic> json, {this.key}) {
    type = json['type'];
    desc = json['desc'];
  }

  Content.fromMap(Map<dynamic, dynamic> map, {this.key})
      : assert(map['type'] != null),
        assert(map['desc'] != null),
        type = map['type'],
        desc = map['desc'];

  Content.fromSnapshot(DataSnapshot snapshot)
      : this.fromMap(snapshot.value, key: snapshot.key);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['desc'] = this.desc;
    return data;
  }
}
