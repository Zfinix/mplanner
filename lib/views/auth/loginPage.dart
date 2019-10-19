import 'package:flutter/material.dart';
import 'package:mplanner/views/home/controller.dart';
import 'package:mplanner/utils/margin.dart';
import 'package:mplanner/utils/validator.dart' as validator;
import 'package:firebase_auth/firebase_auth.dart';
import 'baseAuth.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final BaseAuth auth = new Auth();
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
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
                          _buildEmailField(),
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

  postData() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      String userId = "";
      try {
        userId = await auth.signIn(email, password);
        print('Signed in: $userId');

        if (userId.length > 0 && userId != null) {
          FirebaseUser user = await auth.getCurrentUser();
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Controller(user: user),
            ),
          );
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          isLoading = false;
        });
        if (e.toString().contains("invalid")) {
          showDialog(
              context: context,
              builder: (_) => new AlertDialog(
                    title: new Text("Error"),
                    content: new Text("This password is invalid"),
                  ));
        } else if (e.toString().contains('ERROR_USER_NOT_FOUND')) {
          showDialog(
              context: context,
              builder: (_) => new AlertDialog(
                    title: new Text("Error"),
                    content: new Text("There is no user record corresponding to this identifier. The user may have been deleted"),
                  ));
        }
      }
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
        onPressed: () => postData(),
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
