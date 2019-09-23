import 'package:firebase_database/firebase_database.dart';
import 'package:mplanner/views/auth/baseAuth.dart';
import 'package:flutter/material.dart';
import 'package:mplanner/views/home/controller.dart';
import 'package:mplanner/widgets/imageBgWidget.dart';
import 'package:mplanner/utils/margin.dart';
import 'package:mplanner/utils/validator.dart' as validator;
import 'package:firebase_auth/firebase_auth.dart';


class RegisterPage extends StatefulWidget {
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final reference = FirebaseDatabase.instance.reference().child('users');

  final BaseAuth auth = new Auth();
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String name;
  String cmPassword;

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ImageBGScaffold(
      child: _buildUI(),
      bg: 'food2',
    );
  }

  _buildUI() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Theme(
            data: ThemeData(
                primaryColor: Colors.white,
                accentColor: Colors.white,
                hintColor: Colors.white,
                inputDecorationTheme: new InputDecorationTheme(
                    labelStyle: new TextStyle(color: Colors.green))),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  yMargin20,
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 90,
                  ),
                  yMargin30,
                  Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          _buildNameField(),
                          yMargin30,
                          _buildEmailField(),
                          yMargin30,
                          _buildCmPasswordField(),
                          yMargin30,
                          _buildPasswordField(),
                          yMargin40,
                          Container(
                            child: isLoading
                                ? Container(
                                    width: 120,
                                    height: 40,
                                    child: Center(
                                      child: LinearProgressIndicator(),
                                    ))
                                : Container(
                                    height: 60,
                                    padding:
                                        EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                                    width: MediaQuery.of(context).size.width,
                                    child: _loginButton(),
                                  ),
                          ),
                        ],
                      ))
                ],
              ),
            )));
  }

  newChatAccount() async {
    if (_formKey.currentState.validate()) {
      String userId = "";

      setState(() {
        isLoading = true;
      });

      try {
        print('$email, $password');
        userId = await auth.signUp(email, password);

        saveChatAccountData(name, email, userId);

        print('Signed in to FirebaseAuth: $userId');

        if (userId.length > 0 && userId != null) {}
      } catch (e) {
        print('Error: $e');
        //errorDialog(context, error: e);
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  saveChatAccountData(String name, String email, userId) async {
    try {
      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
      FirebaseUser user = await _firebaseAuth.currentUser();

      FirebaseAuth.instance.currentUser().then((val) {
        UserUpdateInfo updateUser = UserUpdateInfo();
        updateUser.displayName = name;
        // updateUser.photoUrl = prefs.getString("profilePic");

        print("Creating ${user.email}'s Firebase Chat Account");
        val.updateProfile(updateUser).then((onValue) {
          reference.push().set({
            'userId': userId,
            'email': user.email,
            'userName': name,
            'userPhotoUrl': '',
          }).then((value) async {
            setState(() {
              isLoading = false;
            });
            FirebaseUser user = await auth.getCurrentUser();
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Controller(user: user),
              ),
            );
          });
        });
      });
    } catch (e) {
      print('Error: $e');

      setState(() {
        isLoading = false;
      });
    }
  }

  _loginButton() {
    return Container(
      width: 169,
      height: 50,
      child: FlatButton(
        child: Text('LOGIN'),
        color: Colors.lightGreen,
        textColor: Colors.white,
        onPressed: () => newChatAccount(),
      ),
    );
  }

  _buildPasswordField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
      child: TextFormField(
        //initialValue: 'qqqqqq',
        validator: (value) {
          if (value.length > 4) {
            setState(() {
              password = value;
            });
            return null;
          } else if (value.isEmpty) {
            return "This field can't be left empty";
          } else {
            return "Password is Invalid";
          }
        },
        style: new TextStyle(color: Colors.white),
        decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(fontSize: 16, color: Colors.white)),
        keyboardType: TextInputType.text,
        obscureText: true,
      ),
    );
  }

  _buildCmPasswordField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
      child: TextFormField(
        //initialValue: 'qqqqqq',
        validator: (value) {
          if (value == password) {
            setState(() {
              cmPassword = value;
            });
            return null;
          } else if (value.isEmpty) {
            return "This field can't be left empty";
          } else {
            return "Password is Invalid";
          }
        },
        style: new TextStyle(color: Colors.white),
        decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(fontSize: 16, color: Colors.white)),
        keyboardType: TextInputType.text,
        obscureText: true,
      ),
    );
  }

  _buildNameField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
      child: TextFormField(
        //initialValue: 'Ogbonda Chiziaruhoma',
        validator: (value) {
          if (value != null) {
            setState(() {
              name = value;
            });
            return null;
          } else if (value.isEmpty) {
            return "This field can't be left empty";
          } else {
            return "Name is Invalid";
          }
        },
        style: new TextStyle(color: Colors.white),
        decoration: InputDecoration(
            labelText: 'Name',
            labelStyle: TextStyle(fontSize: 16, decorationColor: Colors.green)),
        //  keyboardType: TextInputType.number,
      ),
    );
  }

  _buildEmailField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
      child: TextFormField(
       // initialValue: 'chiziaruhoma@gmail.com',
        validator: (value) {
          if (validator.isEmail(value)) {
            setState(() {
              email = value;
            });
            return null;
          } else if (value.isEmpty) {
            return "This field can't be left empty";
          } else {
            return "Email is Invalid";
          }
        },
        style: new TextStyle(color: Colors.white),
        decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(fontSize: 16, decorationColor: Colors.green)),
        //  keyboardType: TextInputType.number,
      ),
    );
  }
}
