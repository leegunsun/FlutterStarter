import 'package:dateapp/core/utils/json_utility.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalSecureStorage {
  static final FlutterSecureStorage storage = FlutterSecureStorage();


  static  final AndroidOptions _defaultAndroidOptionsAN = AndroidOptions();
  static  final IOSOptions _defaultAndroidOptionsIOS = IOSOptions();

  static Future<void> write({required String key, required dynamic value}) async {
    final encoded = JsonUtils.encodeToJson(key: key, value: value);
    if (encoded == null) {
      throw Exception("인코딩된 값이 null입니다.");
    }
    await storage.write(
      key: key,
      value: encoded,
      aOptions: _defaultAndroidOptionsAN,
      iOptions: _defaultAndroidOptionsIOS,
    );
  }

  // 읽기
  static Future<List<dynamic>> read ({required String key}) async {
    String? _getData = await storage.read(key: key);
    Map<String, dynamic> _result = JsonUtils.decodeFromJson(value: _getData, keyName : key);

    return _result[key];
  }

  // 전체 읽기
  static Future<Map<String, String>> readAll () async {
    return await storage.readAll();
  }

  // 특정 값 삭제
  static Future<void> delete ({required String key}) async {
    return await storage.delete(key: key);
  }

  // 전체 삭제
  static Future<void> deleteAll ({required bool Are_you_sure_want_to_delete_ALL_DATA}) async {
    if(Are_you_sure_want_to_delete_ALL_DATA) {
      print("로컬 데이터 삭제 시작");
      return await storage.deleteAll();
    } else {
      print("로컬 데이터를 삭제하지 않았습니다. Are_you_sure_want_to_delete_all_data = $Are_you_sure_want_to_delete_ALL_DATA");
    }
  }
}