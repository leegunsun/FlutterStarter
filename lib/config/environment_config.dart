library EnviromentConfig;

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'api/debug_api.dart';
part 'api/release_api.dart';

class EnvironmentConfig {

  static final _ConstantsConfig constants = _ConstantsConfig();
  static final _EnvConfig env = _EnvConfig();
  static final _ApiConfig api = kDebugMode ? _ApiDebugConfig() : _ApiReleaseConfig();

  static Future<void> init() async {
    try {
      await dotenv.load(fileName: "assets/.env");
    } catch (e) {
      print("Error loading .env file: $e");
    }
  }
}

class _ConstantsConfig extends EnvironmentConfig {

  String get SEARCH_HISTORY => "search_history";
  String get THIS_APP_NAME => "com.ddate.dateapp";
}


class _EnvConfig extends EnvironmentConfig {

  String get X_Naver_Client_Id => dotenv.env['NAVER_CLIENT_ID'] ?? '';
  String get X_Naver_Client_Secret => dotenv.env['NAVER_CLIENT_SECRET'] ?? '';
  String get APPS_FLYER_DEV_KEY => dotenv.env['APPS_FLYER_DEV_KEY'] ?? '';
}


