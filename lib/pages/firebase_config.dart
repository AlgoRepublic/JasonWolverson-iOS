import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'helper_notification.dart';
class FirebaseNotifications {
  final model;
  final notifications = FlutterLocalNotificationsPlugin();
  FirebaseNotifications(this.model);

  FirebaseMessaging _firebaseMessaging;

  void setUpFirebase() {
    _firebaseMessaging = FirebaseMessaging();
    firebaseCloudMessaging_Listeners();
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();


    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        showMessage(message);
        print(message);
        print("Hmza");


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
}

