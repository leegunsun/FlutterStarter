library;

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'debug/debug_api.dart';
part 'debug/debug_env_config.dart';
part 'debug/debug_constants_config.dart';

part 'release/release_api.dart';
part 'release/release_constants_config.dart';
part 'release/release_env_config.dart';

part '../core/navigation/navigation_routes.dart';

class EnvironmentConfig {

  static final ConstantsConfig constants = ConstantsConfig._instance;
  static final EnvConfig env = EnvConfig._instance;
  static final ApiConfig api = ApiConfig._instance;
  static final AppRoutes route = AppRoutes();

  static Future<void> init() async {
    try {
      await dotenv.load(fileName: "assets/.env");
    } catch (e) {
      print("Error loading .env file: $e");
    }
  }
}





