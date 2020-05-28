import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'helper_notification.dart';

class FirebaseNotifications {
  final model;
  final notifications = FlutterLocalNotificationsPlugin();
  FirebaseNotifications(this.model);

  FirebaseMessaging _firebaseMessaging;

  void setUpFirebase() {
    print("firebase message 1");
    _firebaseMessaging = FirebaseMessaging();
    firebaseCloudMessaging_Listeners();
    print("firebase message 2");
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();
    _firebaseMessaging.getToken().then((token) {
      print("New Token");
      updateToken(token);
    });
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        showMessage(message);
        print(message);
        print("hamza message");
      },
      onResume: (Map<String, dynamic> message) async {
        showMessage(message);
        print(message);
        print("Hmza1");
      },
      onLaunch: (Map<String, dynamic> message) async {
        showMessage(message);
        print(message);
        print("Hmza2");
      },
      /* onBackgroundMessage: (Map<String, dynamic> message) async {
        print('on background message $message');
      },*/
    );

    _firebaseMessaging
        .requestNotificationPermissions(const IosNotificationSettings(
      sound: true,
      badge: true,
      alert: true,
    ));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  Future<void> showMessage(Map<String, dynamic> message) async {
    showOngoingNotification(notifications,
        title: message['notification']['title'],
        body: message['notification']['body']);

    model.getAllChat();
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  void updateToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int userId = prefs.getInt('userId');
    print("userId= $userId");
    final Map<String, dynamic> data = {
      'user_id': userId.toString(),
      'fcm_token': token,
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
      print("token changed");
    } else {
      jsonResponse = json.decode(response.body);
      var success = jsonResponse["success"];
      print(jsonResponse);
      print(success);
      print(response.body);
    }
  }
}