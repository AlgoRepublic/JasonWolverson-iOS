//import 'dart:convert';
//import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:jasonw/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'auh_register.dart';

enum AuthMode { Login }

class Auth extends StatefulWidget {
  @override
//  _AuthState createState() => _AuthState();
  State<StatefulWidget> createState() {
    return _AuthState();
  }
}

class _AuthState extends State<Auth> {
  bool rememberMe = false;

  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null
//    'acceptTerms': false
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _validatepassword = false;
//TextEditingController email = new TextEditingController();
//TextEditingController password = new TextEditingController();
//final TextEditingController _passwordTextController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'E-Mail', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      obscureText: true,
//      controller: _passwordTextController,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password invalid';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

//  Widget _buildPasswordConfirmTextField() {
//    return TextFormField(
//      decoration: InputDecoration(
//          labelText: 'Confirm Password', filled: true, fillColor: Colors.white),
//      obscureText: true,
////      validator: (String value) {
////        if (_passwordTextController.text != value) {
////          return 'Passwords do not match.';
////        }
////      },
//    );
//  }

  void _submitForm(Function login) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Map<String, dynamic> successInformation;
    successInformation = await login(_formData['email'], _formData['password']);

    if (successInformation['success']) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('An Error Occurred!'),
            content: Text(successInformation['message']),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
  }

//Future<List> _login() async {
//
//
//  final response = await http.post('https://app.jasonwolverson.net/api/auth/login' , body:{
//    'email':email.text,
//    'password':password.text,
//  });
//
//  print(response.body);
//
//}

  void _onRememberMeChanged(bool newValue) => setState(() {
        rememberMe = newValue;

        if (rememberMe) {
          // TODO: Here goes your functionality that remembers the user.
        } else {
          // TODO: Forget the user
        }
      });

  TapGestureRecognizer _recognizer1;
  @override
  void initState() {
    super.initState();

    //    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
//    var ios = new IOSInitializationSettings();
//    var platform = new InitializationSettings(android, ios);
//    flutterLocalNotificationsPlugin.initialize(platform);

    _recognizer1 = TapGestureRecognizer()
      ..onTap = () {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new AuthRegister()));
      };
  }

//  showNotification(Map<String, dynamic> msg) async {
//    var android = new AndroidNotificationDetails(
//      'sdffds dsffds',
//      "CHANNLE NAME",
//      "channelDescription",
//    );
//    var iOS = new IOSNotificationDetails();
//    var platform = new NotificationDetails(android, iOS);
//    await flutterLocalNotificationsPlugin.show(
//        0, "This is title", "this is demo", platform);
//  }

  update(String token) {
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    return Scaffold(
      backgroundColor: Colors.white,

      body: new ListView(
        children: <Widget>[
          new Container(
            color: Colors.white,
//              height: 250,
            child: new GridTile(
              child: new Container(
//                  color: Colors.black,

                child: Image.asset(
                  'images/login-img.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          new Row(
            children: <Widget>[
              new Container(
                color: Colors.white,
                child: new Container(
                  margin: const EdgeInsets.fromLTRB(35.0, 15.0, 15.0, 15.0),
                  padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0, 2),
                  decoration: new BoxDecoration(
                    border: new Border(
                      bottom: new BorderSide(
                        color: hexToColor("#3A3171"),
                        width: 1.0,
                        style: BorderStyle.solid,
                      ),
                    ),
//                border: new Border.all(color: Colors.blueAccent ,)
                  ),
                  child: new Text(
                    'LOGIN',
                    style: TextStyle(
                        fontSize: 24.0,
                        color: hexToColor("#3A3171"),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.0,
                        fontFamily: 'opensans'),
                  ),
                ),
              )
            ],
          ),
          new Form(
            key: _formKey,
            child: new Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
              child: new Container(
                child: new Center(
                  child: new Column(
                    children: <Widget>[
                      new Padding(padding: const EdgeInsets.only(top: 5.0)),
                      new TextFormField(
//                        controller: email,
                        decoration: new InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            labelText: 'Email',
                            labelStyle: new TextStyle(
                                color: hexToColor("#3A3171"),
                                fontFamily: 'opensans'),
                            suffixIcon: Icon(
                              Icons.email,
                              size: 18.0,
                              color: hexToColor("#3A3171"),
                            ),
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(4.0),
                                borderSide: new BorderSide(
                                    color: Colors.yellow, width: 0.0))),

                        validator: (val) {
                          if (val.length == 0) {
                            return "Email Cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (String value) {
                          _formData['email'] = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(
                            fontFamily: 'open sans',
                            color: hexToColor("#3A3171"),
                            fontSize: 13.0,
                            height: 1.0),
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 15.0)),
                      new TextFormField(
//                        controller: password,
                        obscureText: true,
                        decoration: new InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            labelText: 'Password',
                            labelStyle: new TextStyle(
                                color: hexToColor("#3A3171"),
                                fontFamily: 'opensans'),
                            errorText:
                                _validatepassword ? 'Invalid Password' : null,
//                            hintText: 'Password',
//                            hintStyle: new st,
                            hasFloatingPlaceholder: true,
                            alignLabelWithHint: true,
                            suffixIcon: Icon(
                              Icons.remove_red_eye,
                              size: 18.0,
                              color: hexToColor("#3A3171"),
                            ),
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(4.0),
                                borderSide:
                                    new BorderSide(color: Colors.blue[700]))),
                        onChanged: (value) {
                          if (value.isEmpty || value.length < 6) {
                            setState(() {
                              _validatepassword = true;
                            });
                          } else {
                            setState(() {
                              _validatepassword = false;
                            });
                          }
                        },
                        validator: (val) {
                          if (val.length == 0) {
                            return "Password Cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (String value) {
                          _formData['password'] = value;
                        },
//                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(
                            fontFamily: 'opensans',
                            color: hexToColor("#3A3171"),
                            fontSize: 13.0),
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 8.0)),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Checkbox(
                                activeColor: Colors.grey,
                                value: rememberMe,
                                onChanged: _onRememberMeChanged),
                            Text('Remember me'),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: new Text('Forgot Password?',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: hexToColor("#3A3171"),
                                        fontFamily: 'opensans'),
                                    textAlign: TextAlign.right),
                              ),
                            )
                          ],
                        ),
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 35.0)),
                      Row(
                        children: <Widget>[
//                          Expanded(
//
//                            child: new MaterialButton(
//                              color: hexToColor("#3A3171"),
//                              textColor: Colors.white,
//                              elevation: 0.0,
//                              height: 52,
//                              onPressed: (){
////                                _login();
////                                Navigator.push(context, MaterialPageRoute(builder:(context)=> new Dashboard() ));
//                              },
//                              child: new Text('LOGIN', style: TextStyle(fontSize: 14.0 , fontFamily: 'opensans'),),
//                            )
//                          )
                        ],
                      ),
                      ScopedModelDescendant<MainModel>(
                        builder: (BuildContext context, Widget child,
                            MainModel model) {
                          if (model.isLoading) {
                            return CircularProgressIndicator();
                          } else {
                            return new Row(
                              children: <Widget>[
                                Expanded(
                                  child: MaterialButton(
                                    color: hexToColor("#3A3171"),
                                    textColor: Colors.white,
                                    elevation: 0.0,
                                    height: 52,
                                    //                                minWidth: double.infinity,
                                    //                            child: Text(_authMode == AuthMode.Login
                                    //                                ? 'LOGIN'
                                    //                                : 'SIGNUP'),
                                    onPressed: () => _submitForm(model.login),
                                    child: new Text(
                                      'LOGIN',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: 'opensans'),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          ;
                        },
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 55.0)),
                      Row(
                        children: <Widget>[
                          Expanded(
//                            child: Text(
//                              'Text',
//                                textAlign: TextAlign.center,
//                            )

                            child: Text.rich(
                              TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "Don't have an account? ",
                                      style: TextStyle(color: Colors.black)),
                                  TextSpan(
                                      text: 'Register now',
                                      recognizer: _recognizer1,
                                      style: TextStyle(
                                          color: hexToColor("#3A3171"),
                                          decoration:
                                              TextDecoration.underline)),
                                ],
                              ),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14.0, fontFamily: 'opensans'),
                            ),

//                            child: new Text("Don't have an account?" ,
//                                style: TextStyle(fontSize: 13.0), textAlign: TextAlign.center,
//                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

//      body: Container(
//        decoration: BoxDecoration(
////          image: _buildBackgroundImage(),
//        ),
//        padding: EdgeInsets.all(10.0),
//        child: Center(
//          child: SingleChildScrollView(
//            child: Container(
////              width: targetWidth,
//              child: Form(
//                key: _formKey,
//                child: Column(
//                  children: <Widget>[
//                    _buildEmailTextField(),
//                    SizedBox(
//                      height: 10.0,
//                    ),
//                    _buildPasswordTextField(),
////                    SizedBox(
////                      height: 10.0,
////                    ),
////                    _authMode == AuthMode.Signup
////                        ? _buildPasswordConfirmTextField()
////                        : Container(),
////                    _buildAcceptSwitch(),
////                    SizedBox(
////                      height: 10.0,
////                    ),
//////                    FlatButton(
//////                      child: Text(
//////                          'Switch to ${_authMode == AuthMode.Login ? 'Signup' : 'Login'}'),
//////                      onPressed: () {
//////                        setState(() {
//////                          _authMode = _authMode == AuthMode.Login
////////                              ? AuthMode.Signup
//////                              : AuthMode.Login;
//////                        });
//////                      },
//////                    ),
//                    SizedBox(
//                      height: 10.0,
//                    ),
//                    ScopedModelDescendant<MainModel>(
//                      builder: (BuildContext context, Widget child,
//                          MainModel model) {
//                        return model.isLoading
//                            ? CircularProgressIndicator()
//                            :
//                        RaisedButton(
//                          textColor: Colors.white,
//                          onPressed: () =>
//                              _submitForm(model.login,),
//                        );
//                      },
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ),
//        ),
//      ),
    );
  }
}
