part of 'local_secure_source.dart';

class _LocalSecureSourceGet extends LocalSecureSource {

  Future<String?> getSecureItem (String key) async {
    return await LocalSecureStorage.read(key: key);
  }

}