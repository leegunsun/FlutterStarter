part of 'local_secure_source.dart';

class _LocalSecureSourceSet extends LocalSecureSource {

  Future<void> searchInputHistory ({required List<String> value}) async {
    await LocalSecureStorage.write(key: EnvironmentConfig.constants.SEARCH_HISTORY, value: value);
  }

}