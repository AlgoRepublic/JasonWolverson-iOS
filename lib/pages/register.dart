import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;

import 'auth.dart';
//import 'package:async/async.dart';
//import 'package:flutter/http'
//import 'package:sky_engine/_http/';



class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


   TextEditingController email = new TextEditingController();
   TextEditingController password = new TextEditingController();

  Future<Map<String , dynamic>> _Register () async{


    final  Map<String, dynamic> authData = {
      'user':{
        'email' :  email.text,
        'password': password.text,
        'auth_token': true,
        }
    };

    final http.Response response = await http.post(
      'http://68.183.187.228/api/users',
      body: json.encode(authData),
      headers: {'Content-Type': 'application/json'},
    );

    print(response.body);

  }


  TapGestureRecognizer _recognizer1;
  @override
  void initState() {
    super.initState();
    _recognizer1 = TapGestureRecognizer()
      ..onTap = () {
        Navigator.push(context, new MaterialPageRoute(builder: (context) => new Auth() ));
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
                  child: new Text('REGISTER', style: TextStyle(fontSize: 24.0 , color:hexToColor("#3A3171") , fontWeight: FontWeight.w600, letterSpacing: 0.0, fontFamily: 'opensans') , ),
                ),

              )

            ],
          ),

          new Form(
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
                            labelText: 'Confirm Password',
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

                        validator: (String value){
//                          if (value.length==0){
//                            return "Email Cannot be empty";
//                          }else{
//                            return null;
//                          }

                        if (password.text != value){
                          return 'Passwords do not match';
                        }

                        },
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(fontFamily: 'opensans', color: hexToColor("#3A3171"), fontSize: 13.0),
                      ),

                      new Padding(padding: const EdgeInsets.only(top:8.0)),

//                      new Padding(padding: const EdgeInsets.only(top:35.0)),

                      Row(
                        children: <Widget>[
                          Expanded(

                              child: new MaterialButton(
                                color: hexToColor("#3A3171"),
                                textColor: Colors.white,
                                elevation: 0.0,
                                height: 52,
                                onPressed: (){
                                   _Register();
//                                Navigator.push(context, MaterialPageRoute(builder:(context)=> new Dashboard() ));
                                },
                                child: new Text('Register', style: TextStyle(fontSize: 14.0 , fontFamily: 'opensans'),),
                              )
                          )
                        ],

                      ),

                      new Padding(padding: const EdgeInsets.only(top:45.0)),

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
                                  TextSpan(text: "Already have an account? ",  style: TextStyle(color: Colors.black) ),
                                  TextSpan(
                                      text: 'Login ', recognizer: _recognizer1,  style: TextStyle(color: hexToColor("#3A3171"), decoration: TextDecoration.underline) ),
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
    );
  }
}

