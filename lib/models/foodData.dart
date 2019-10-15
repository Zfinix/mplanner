class FoodDataModel {
  List<FoodData> data;

  FoodDataModel({this.data});

  FoodDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<FoodData>();
      json['data'].forEach((v) {
        data.add(new FoodData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FoodData {
  String day;
  List<Content> content;

  FoodData({this.day, this.content});

  FoodData.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    if (json['content'] != null) {
      content = new List<Content>();
      json['content'].forEach((v) {
        content.add(new Content.fromJson(v));
      });
    }
  }

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

  Content({this.type, this.desc});

  Content.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['desc'] = this.desc;
    return data;
  }
}