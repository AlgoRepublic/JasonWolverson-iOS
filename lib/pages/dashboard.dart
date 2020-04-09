import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
  FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    print("firebase");
    widget.model.autoAuthenticate();

    new FirebaseNotifications(widget.model).setUpFirebase();
    final settingsAndroid = AndroidInitializationSettings('app_icon');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);
    widget.model.getAllChat();
  }

  Future onSelectNotification(String payload) async => await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatRoom(widget.model)),
      );

  

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
