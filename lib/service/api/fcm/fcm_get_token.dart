import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../permission/permission_hand.dart';

class FcmTokenManager {
  static String? token;

  static Future<void> init (BuildContext context) async {
    int _retryCount = 0;

    PerMissionHandle().requestPermission(context);

    token = await FirebaseMessaging.instance.getToken();

    while (token == null && _retryCount < 5) {
      token = await FirebaseMessaging.instance.getToken();
      _retryCount++;
    }

    print(token);

    await createTokenUser();
  }

  static Future<void> createTokenUser () async {

    await FirebaseFirestore.instance.collection("user").doc("master").set({
      "token" : token
    });
  }
}