import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:jasonw/components/card.dart';
import 'package:jasonw/scoped_models/main.dart';

//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'ChatRoom.dart';

class Dashboard extends StatefulWidget {
//  Dashboard(this.model);


  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final MainModel model = MainModel();
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  ChatRoom chatRoom;
//  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    print("firebase");
//    _firebaseMessaging.configure(
//      onMessage: (Map<String, dynamic> message) async {
//        print("onMessagejjj: $message");
//
//        print("ob");
////        Navigator.pushReplacementNamed(context, '/chatRoom');
//        ChatRoom().createState().getAllChat();
//        print("object");
//        final notification = message['notification'];
//        setState(() {
//          print("title =$notification['title']  body = $notification['body']");
//        });
//      },
//      onLaunch: (Map<String, dynamic> message) async {
//        print("onLaunch: $message");
//
//        final notification = message['data'];
//
//        print("title =$notification['title']  body = $notification['body']");
//      },
//      onResume: (Map<String, dynamic> message) async {
//        print("onResume: $message");
//      },
//    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));

    _firebaseMessaging.getToken().then((token) {
      print("Firebase token = $token");
      updateFCM_Token(token);
    });

    model.autoAuthenticate();
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


  updateFCM_Token(String FCM_token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int userId = prefs.getInt('userId');
    print("userId= $userId");
    final Map<String, dynamic> data = {
      'user_id': userId.toString(),
      'fcm_token':FCM_token,
    };
    var jsonResponse;
    http.Response response = await http.post(
      "http://68.183.187.228/api/users/update_fcm_token",
      body: data,
    );
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      var success = jsonResponse["success"];
      print(jsonResponse);
      print(success);
      print(response.body);
    //  showToast(jsonResponse["message"],duration: 4,gravity: Toast.BOTTOM);
//      showToast("Your appointment has been submitted to Jason!",
//          gravity: Toast.BOTTOM);
    } else {
      jsonResponse = json.decode(response.body);
      var success = jsonResponse["success"];
      print(jsonResponse);
      print(success);
      print(response.body);
    //  showToast(jsonResponse["message"], duration: 4, gravity: Toast.BOTTOM);
    }
  }

  Widget _ShowUserInfo() {
//    print('${model.user.email}');
    if (model.user == null) {
      return Text('test@gmail.com');
    } else {
      return Text('${model.user.email}');
    }
  }

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
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Navigator.pushReplacementNamed(
                context, '/dashboard'), // POPPING globalContext
          ),
          actions: <Widget>[
            new IconButton(
                icon: new Image.asset('images/JASON-LOGO-FINAL-4.png'),
                onPressed: () {})
          ],
        ),

//      body: new Container(
//        padding: new EdgeInsets.all(12.0),
//        child: new Center(
//          child: new Column(
//            children: <Widget>[
//              new Card(
//                child: new Container(
//                  padding: new EdgeInsets.all(32.0),
//                  child: new Column(
//                    children: <Widget>[
//                      new Text('Hello World'),
//                      new Text('How are you?')
//                    ],
//                  ),
//                ),
//              ),
//              new Card(
//                child: new Container(
//                  padding: new EdgeInsets.all(32.0),
//                  child: new Column(
//                    children: <Widget>[
//                      new Text('Hello World'),
//                      new Text('How are you?')
//                    ],
//                  ),
//                ),
//              ),
//              new Card(
//                child: new Container(
//                  padding: new EdgeInsets.all(32.0),
//                  child: new Column(
//                    children: <Widget>[
//                      new Text('Hello World'),
//                      new Text('How are you?')
//                    ],
//                  ),
//                ),
//              )
//            ],
//          ),
//        ),
//      ),

        body: new Stack(
          children: <Widget>[
            Container(
              padding: new EdgeInsets.all(15),
//          height:350,
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
