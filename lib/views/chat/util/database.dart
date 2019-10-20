import 'package:mplanner/views/auth/baseAuth.dart';

Map<String, dynamic> foodJSONData = {
  "data": [
    {
      "day": "Monday",
      "content": [
        {"type": "Breakfast", "desc": "Low-Sugar, Bran Flakes"},
        {"type": "Lunch", "desc": "Wheat and Okazi Soup"},
        {
          "type": "Dinner",
          "desc": "Fruits (Watermelon, apple, oranges, avacado)"
        }
      ]
    },
    {
      "day": "Tuesday",
      "content": [
        {
          "type": "Breakfast",
          "desc": "Noodles with vegetables and Fruit Juice"
        },
        {"type": "Lunch", "desc": "Spaghetti and carrot sauce"},
        {"type": "Dinner", "desc": "Semovita and Vegetable Soup"}
      ]
    },
    {
      "day": "Wednesday",
      "content": [
        {"type": "Breakfast", "desc": "Whole Wheat Bread and Green Tea"},
        {"type": "Lunch", "desc": "Porridge Yam and Vegetable"},
        {"type": "Dinner", "desc": "Macaroni and Egg Sauce"}
      ]
    },
    {
      "day": "Thursday",
      "content": [
        {
          "type": "Breakfast",
          "desc": "Jollof Rice and Chicken with Fruit Juice"
        },
        {
          "type": "Lunch",
          "desc": "Fruits (Wattermelon, apple, orange, avacado)"
        },
        {"type": "Dinner", "desc": "Beans and Potato with Vegetables"}
      ]
    },
    {
      "day": "Friday",
      "content": [
        {"type": "Breakfast", "desc": "Low Sugar Cereal"},
        {"type": "Lunch", "desc": "Poridge Plantain and Utazi"},
        {"type": "Dinner", "desc": "Brown Rice and Lightly Steamed vegetables"}
      ]
    },
    {
      "day": "Saturday",
      "content": [
        {"type": "Breakfast", "desc": "Diet Bread egg and coffee"},
        {"type": "Lunch", "desc": "Yogurt and Snack"},
        {"type": "Dinner", "desc": "Noodles with vegetables and Fruit Juice"}
      ]
    },
    {
      "day": "Sunday",
      "content": [
        {"type": "Breakfast", "desc": "Steel-cut Oat Meal"},
        {"type": "Lunch", "desc": "Basmatti Rice and Tomsto Sauce"},
        {"type": "Dinner", "desc": "Cornflour and Bitterleaf Soup"}
      ]
    },
  ]
};

Future<String> getUserImage(userId) async {
  BaseAuth auth = new Auth();
  var v = await auth.getCurrentUserData(userId: userId);
  return v.userPhotoUrl;
}
