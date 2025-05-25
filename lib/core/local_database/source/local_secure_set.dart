part of 'local_secure_source.dart';

class _LocalSecureSourceSet {

  Future<void> searchInputHistory ({required List<String> value}) async {
    await LocalSecureStorage.write(key: EnvironmentConfig.constants.SEARCH_HISTORY, value: value);
  }

  Future<void> searchLastInputHistory ({required List<String> value}) async {
    await LocalSecureStorage.write(key: EnvironmentConfig.constants.SEARCH_LAST_INPUT_HISTORY, value: value);
  }

}