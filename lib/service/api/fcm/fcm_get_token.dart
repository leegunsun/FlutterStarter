import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../permission/permission_hand.dart';

class FcmTokenManager {
  static String? token;
   final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://sendpushnotification-tzvcof2hmq-uc.a.run.app"
    )
  );

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

  Future<void> sendTest ({String? title, String? body}) async {

    if(token == null) {
      print("다이나믹 링크 토큰 발생 실패");
      return;
    }

    _dio.post("/",data: {
      "token" : token,
      "title" : title ?? "",
      "body" : body ?? ""
    });
  }
}