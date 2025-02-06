import 'dart:convert';
import 'dart:io';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:dateapp/service/api/fcm/fcm_get_token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppsflyerController {

  static late AppsflyerSdk appsflyerSdk;
  static AppsFlyerOptions? appsFlyerOptions;
  static Map _deepLinkData = {};
  static Map _gcd = {};

  static void init () {
    try {
      appsFlyerOptions = AppsFlyerOptions(
              afDevKey: dotenv.env["APPS_FLYER_DEV_KEY"]!,
              appId: "com.ddate.dateapp",
              showDebug: true,
              timeToWaitForATTUserAuthorization: 15,
              manualStart: true);
    } catch (e) {
      print("appsFlyerOptions init error");
    }
  }

  static Future<void> afStart({required Function(Map) onGcdUpdate, required Function(Map) onDeepLinkUpdate}) async {
    // SDK Options

    /*
    final Map? map = {
      'afDevKey': dotenv.env["DEV_KEY"]!,
      'appId': dotenv.env["APP_ID"]!,
      'isDebug': true,
      'timeToWaitForATTUserAuthorization': 15.0//,
      //'manualStart': false
    };
    _appsflyerSdk = AppsflyerSdk(map);
     */

    appsflyerSdk = AppsflyerSdk(appsFlyerOptions);

    /*
    Setting configuration to the SDK:
    _appsflyerSdk.setCurrencyCode("USD");
    _appsflyerSdk.enableTCFDataCollection(true);
    var forGdpr = AppsFlyerConsent.forGDPRUser(hasConsentForDataUsage: true, hasConsentForAdsPersonalization: true);
    _appsflyerSdk.setConsentData(forGdpr);
    var nonGdpr = AppsFlyerConsent.nonGDPRUser();
    _appsflyerSdk.setConsentData(nonGdpr);
     */

    // Init of AppsFlyer SDK
    await appsflyerSdk.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true);

    // Conversion data callback
    appsflyerSdk.onInstallConversionData((res) {
      print("onInstallConversionData res: " + res.toString());
      _gcd = res;
      onGcdUpdate(_gcd);
    });

    // App open attribution callback
    AppsflyerController.appsflyerSdk.onAppOpenAttribution((res) {
      print("onAppOpenAttribution res: " + res.toString());
      // _deepLinkData = res;
      // onDeepLinkUpdate(_deepLinkData);
    });

    // Deep linking callback
    appsflyerSdk.onDeepLinking((DeepLinkResult dp) {
      switch (dp.status) {
        case Status.FOUND:
          print(dp.deepLink?.toString());
          print("deep link value: ${dp.deepLink?.deepLinkValue}");
          Map<String, dynamic> _result = jsonDecode(jsonEncode(dp.toJson()));
          FcmTokenManager().sendTest(title: _result["deepLink"]["host"], body: _result["deepLink"]["deep_link_value"]);

          break;
        case Status.NOT_FOUND:
          print("deep link not found");
          break;
        case Status.ERROR:
          print("deep link error: ${dp.error}");
          break;
        case Status.PARSE_ERROR:
          print("deep link status parsing error");
          break;
      }
      print("onDeepLinking res: " + dp.toString());

      _deepLinkData = dp.toJson();
      onDeepLinkUpdate(_deepLinkData);
    });

    //_appsflyerSdk.anonymizeUser(true);
    if (Platform.isAndroid) {
      appsflyerSdk.performOnDeepLinking();
    }
  }

  Future<bool?> logEvent(String eventName, Map eventValues) async {
    bool? logResult;
    try {
      logResult = await appsflyerSdk.logEvent(eventName, eventValues);
      print("Event logged");
    } catch (e) {
      print("Failed to log event: $e");
    }
    return logResult;
  }

  static void appsflyerGenerateLink ({
    required AppsFlyerInviteLinkParams? parameters,
    required void Function(dynamic) success,
    required void Function(dynamic) error}) {

    appsflyerSdk.generateInviteLink(parameters, success, error);

  }

  static void setAppInviteOneLinkID ({
    required String oneLinkID,
    required void Function(dynamic) callback}) {

    appsflyerSdk.setAppInviteOneLinkID(oneLinkID, callback);

  }
}