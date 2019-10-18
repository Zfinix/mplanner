import 'package:shared_preferences/shared_preferences.dart';

///-------------PROFILE DATA----------------///
/* saveProfileData({ProfileModel profileData, LoginModel loginData}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  print('Saved Profile Data');
  await prefs.setString('loginData', json.encode(loginData.toJson()));
  await prefs.setString('profileData', json.encode(profileData.toJson()));
}

eraseProfileData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  print('Erased Profile Data');
  await prefs.remove('loginData');
  await prefs.remove('profileData');
}

Future<GetProfileData> getProfileData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  print('Fetch Profile Data');
  ProfileModel profileData =
      ProfileModel.fromJson(json.decode(prefs.getString('profileData')));

  LoginModel loginData =
      LoginModel.fromJson(json.decode(prefs.getString('loginData')));

  return new GetProfileData(loginData: loginData, profileData: profileData);
}
 */
saveItem({item, key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  print('Saved New Item Data');
   prefs.setString('$key', item);
}

eraseItem({key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  print('Erased New Item Data');
  prefs.remove('$key');
}

Future<dynamic> getItemData({key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString('$key');
}

/* class GetProfileData {
  final ProfileModel profileData;
  final LoginModel loginData;

  GetProfileData({@required this.profileData, @required this.loginData});
}
 */