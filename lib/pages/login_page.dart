//import 'dart:convert';
//import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:jasonw/pages/register.dart';
import 'package:jasonw/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

enum AuthMode { Login }


class Auth extends StatefulWidget {
  @override
//  _AuthState createState() => _AuthState();
  State<StatefulWidget> createState() {
    return _AuthState();
  }
}

class _AuthState extends State<Auth> {

  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null
//    'acceptTerms': false
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  void _submitForm(Function login) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Map<String, dynamic> successInformation;
    if (_authMode == AuthMode.Login) {
      successInformation =
      await login(_formData['email'], _formData['password']);
    }

    if (successInformation['success']) {
      Navigator.pushReplacementNamed(context, '/dashbaord');
    }
    else {
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
//  final response = await http.post('http://68.183.187.228/api/auth/login' , body:{
//    'email':email.text,
//    'password':password.text,
//  });
//
//  print(response.body);
//
//}




  TapGestureRecognizer _recognizer1;
  @override
  void initState() {
    super.initState();
    _recognizer1 = TapGestureRecognizer()
      ..onTap = () {
        Navigator.push(context, new MaterialPageRoute(builder: (context) => new Register() ));
      };

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

                child: Image.asset('images/login-img.png' , fit: BoxFit.fill,),
              ),
            ),
          ),
          new Row(
            children: <Widget>[
              new Container(
                color: Colors.white,
                child: new Container(
                  margin: const EdgeInsets.fromLTRB(35.0 , 15.0 , 15.0 ,15.0),
                  padding: const EdgeInsets.fromLTRB(0.0,2.0,0,2),
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
                  child: new Text('LOGIN', style: TextStyle(fontSize: 24.0 , color:hexToColor("#3A3171") , fontWeight: FontWeight.w600, letterSpacing: 0.0, fontFamily: 'opensans') , ),
                ),

              )

            ],
          ),

          new Form(
            key: _formKey,
            child: new Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(25.0, 10.0 ,25.0, 10.0),
              child:new Container(

                child: new Center(
                  child: new Column(
                    children: <Widget>[
                      new Padding(padding: const EdgeInsets.only(top:5.0)),
                      new TextFormField(
                        controller: email,
                        decoration: new InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            labelText: 'email',
                            labelStyle: new TextStyle(color: hexToColor("#3A3171") , fontFamily: 'opensans'),
                            suffixIcon: Icon(
                              Icons.email,
                              size: 18.0,
                              color: hexToColor("#3A3171"),
                            ),
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(4.0),
                                borderSide: new BorderSide(
                                    color: Colors.yellow , width: 0.0
                                )
                            )
                        ),

                        validator: (val){
                          if (val.length==0){
                            return "Email Cannot be empty";
                          }else{
                            return null;
                          }

                        },
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(fontFamily: 'open sans', color: hexToColor("#3A3171"), fontSize: 13.0,height: 1.0),
                      ),
                      new Padding(padding: const EdgeInsets.only(top:15.0)),
                      new TextFormField(
                        controller: password,
                        obscureText: true,
                        decoration: new InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            labelText: 'Password',
                            labelStyle: new TextStyle(color: hexToColor("#3A3171") , fontFamily: 'opensans'),
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
                                borderSide: new BorderSide(
                                    color: Colors.blue[700]
                                )
                            )
                        ),

                        validator: (val){
                          if (val.length==0){
                            return "Email Cannot be empty";
                          }else{
                            return null;
                          }

                        },
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(fontFamily: 'opensans', color: hexToColor("#3A3171"), fontSize: 13.0),
                      ),


                      new Padding(padding: const EdgeInsets.only(top:8.0)),

                      Row(
                        children: <Widget>[
//
                          Expanded(
                            child: InkWell(
                              onTap: (){},
                              child: new Text('Forgot Password?', style: TextStyle(fontSize: 13.0, color: hexToColor("#3A3171"), fontFamily: 'opensans'), textAlign: TextAlign.right),

                            ),
                          )
                        ],

                      ),


                      new Padding(padding: const EdgeInsets.only(top:35.0)),

//                      Row(
//                        children: <Widget>[
//                          Expanded(
//
//                            child: new MaterialButton(
//                              color: hexToColor("#3A3171"),
//                              textColor: Colors.white,
//                              elevation: 0.0,
//                              height: 52,
//                              onPressed: (){
//                                _login();
////                                Navigator.push(context, MaterialPageRoute(builder:(context)=> new Dashboard() ));
//                              },
//                              child: new Text('LOGIN', style: TextStyle(fontSize: 14.0 , fontFamily: 'opensans'),),
//                            )
//                          )
//                        ],
//
//                      ),

                      ScopedModelDescendant<MainModel>(
                        builder: (BuildContext context, Widget child,
                            MainModel model) {

                          return model.isLoading
                              ? CircularProgressIndicator()
                              : MaterialButton(
                              color: hexToColor("#3A3171"),
                              textColor: Colors.white,
                              elevation: 0.0,
                              height: 52,
//                            child: Text(_authMode == AuthMode.Login
//                                ? 'LOGIN'
//                                : 'SIGNUP'),
                            onPressed: () =>
                                _submitForm(model.login),
                            child: new Text('LOGIN', style: TextStyle(fontSize: 14.0 , fontFamily: 'opensans'),),
                          );
                        },
                      ),

                      new Padding(padding: const EdgeInsets.only(top:55.0)),


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
                                  TextSpan(text: "Don't have an account? ",  style: TextStyle(color: Colors.black) ),
                                  TextSpan(
                                      text: 'Register now', recognizer: _recognizer1,  style: TextStyle(color: hexToColor("#3A3171"), decoration: TextDecoration.underline) ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: 'opensans'

                              ),

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
////                    _buildEmailTextField(),
////                    SizedBox(
////                      height: 10.0,
////                    ),
//////                    _buildPasswordTextField(),
////                    SizedBox(
////                      height: 10.0,
////                    ),
//////                    _authMode == AuthMode.Signup
//////                        ? _buildPasswordConfirmTextField()
//////                        : Container(),
//////                    _buildAcceptSwitch(),
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

