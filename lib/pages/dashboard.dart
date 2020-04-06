import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jasonw/components/card.dart';
import 'package:jasonw/scoped_models/main.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'ChatRoom.dart';
import 'firebase_config.dart';

class Dashboard extends StatefulWidget {
  final model;

  Dashboard(this.model);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  void initState() {
    super.initState();
    print("firebase");
    widget.model.autoAuthenticate();

    new FirebaseNotifications(widget.model).setUpFirebase();
    
    widget.model.getAllChat();
  }

  Future onSelectNotification(String payload) async => await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatRoom(widget.model)),
      );

  // updateFCM_Token(String FCM_token) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final int userId = prefs.getInt('userId');
  //   print("userId= $userId");
  //   final Map<String, dynamic> data = {
  //     'user_id': userId.toString(),
  //     'fcm_token': FCM_token,
  //   };
  //   var jsonResponse;
  //   http.Response response = await http.post(
  //     "http://68.183.187.228/api/users/update_fcm_token",
  //     body: data,
  //   );
  //   if (response.statusCode == 200) {
  //     jsonResponse = json.decode(response.body);
  //     var success = jsonResponse["success"];
  //     print(jsonResponse);
  //     print(success);
  //     print(response.body);
  //   } else {
  //     jsonResponse = json.decode(response.body);
  //     var success = jsonResponse["success"];
  //     print(jsonResponse);
  //     print(success);
  //     print(response.body);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    return Scaffold(
//      backgroundColor: hexToColor('#f4f5f8'),
        appBar: new AppBar(
          backgroundColor: hexToColor("#3A3171"),
          centerTitle: true,
          elevation: 0.0,
          title: new Text(
            'Smash Life',
            style: TextStyle(
                color: Colors.white, fontFamily: 'opensans', fontSize: 16.0),
          ),
          // leading: IconButton(
          //   icon: Icon(Icons.menu),
          //   onPressed: () => Navigator.pushReplacementNamed(
          //       context, '/dashboard'), // POPPING globalContext
          // ),
          actions: <Widget>[
            new IconButton(
                icon: Icon(Icons.home),
                // icon: new Image.asset('images/JASON-LOGO-FINAL-4.png'),
                onPressed: () {})
          ],
        ),
        body: new Stack(
          children: <Widget>[
            Container(
              padding: new EdgeInsets.all(15),
              child: CardHolder(),
            )
          ],
        ));
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(
      msg,
      context,
      duration: duration,
      gravity: gravity,
    );
  }
}
