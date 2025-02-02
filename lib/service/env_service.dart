import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvService {

  static Future<void> init () async {
    try {
      await dotenv.load(fileName: "assets/.env");
    } catch (e) {
      print("Error loading .env file: $e");
    }
  }
}
