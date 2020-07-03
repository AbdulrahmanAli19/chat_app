import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PushNotification {
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  Future initailise({BuildContext context}) async {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (isIOS) {
      _firebaseMessaging
          .requestNotificationPermissions(IosNotificationSettings());
    }
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print("message : ${message.toString()}");
    }, onLaunch: (Map<String, dynamic> message) async {
      print("message : ${message.toString()}");
    }, onResume: (Map<String, dynamic> message) async {
      print("message : ${message.toString()}");
    });
  }
}
