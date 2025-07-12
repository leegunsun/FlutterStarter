import 'dart:convert';

class JsonUtils {
  static String? encodeToJson ({required String key, required dynamic value}) {
    try {
      String _runtimeType =  value.runtimeType.toString();

      if(_runtimeType.toLowerCase() == "null") {
        throw Exception("인코드할 값이 null입니다.");
      }

      if(value != Map) {
        value = Map<String, dynamic>.from({key : value});
      }

      String _jsonEncode = jsonEncode(value);
      return _jsonEncode;
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Map<String, dynamic> decodeFromJson ({required String? value, required String keyName}) {
    try {

      if(value == null) {
        return {keyName : []};
      }

      Map<String, dynamic> _jsonDecode = jsonDecode(value);
      return _jsonDecode;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}