import '../../config/environment_config.dart';
import 'local_secure_storage.dart';

class LocalSecureSource {

  static _LocalSecureSourceSet get set => _LocalSecureSourceSet();
  static _LocalSecureSourceGet get get => _LocalSecureSourceGet();
}

class _LocalSecureSourceSet extends LocalSecureSource {

  Future<void> searchInputHistory ({required List<String> value}) async {
    await LocalSecureStorage.write(key: EnvironmentConfig.constants.SEARCH_HISTORY, value: value);
  }

}

class _LocalSecureSourceGet extends LocalSecureSource {

  Future<List<String?>> searchInputHistory () async {
    Map<String, dynamic>? getSearchData = await LocalSecureStorage.read(key: EnvironmentConfig.constants.SEARCH_HISTORY);
    return (getSearchData?[EnvironmentConfig.constants.SEARCH_HISTORY] is List)
        ? List<String?>.from(getSearchData?[EnvironmentConfig.constants.SEARCH_HISTORY] as List)
        : [];
  }

}