part of 'local_secure_source.dart';

class _LocalSecureSourceGet extends LocalSecureSource {

  Future<List<String?>> searchInputHistory () async {
    Map<String, dynamic>? getSearchData = await LocalSecureStorage.read(key: EnvironmentConfig.constants.SEARCH_HISTORY);
    return (getSearchData?[EnvironmentConfig.constants.SEARCH_HISTORY] is List)
        ? List<String?>.from(getSearchData?[EnvironmentConfig.constants.SEARCH_HISTORY] as List)
        : [];
  }

}