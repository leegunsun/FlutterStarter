import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {

  static Future<void> init () async {
    try {
      await dotenv.load(fileName: "assets/.env");
    } catch (e) {
      print("Error loading .env file: $e");
    }
  }

  static String get X_Naver_Client_Id => dotenv.env['NAVER_CLIENT_ID'] ?? '';
  static String get X_Naver_Client_Secret => dotenv.env['NAVER_CLIENT_SECRET'] ?? '';
  static String get APPS_FLYER_DEV_KEY => dotenv.env['APPS_FLYER_DEV_KEY'] ?? '';
}
