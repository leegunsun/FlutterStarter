part of '../environment_config.dart';

abstract class ConstantsConfig {

  static final _instance = kDebugMode ? _DebugConstantsConfig() : _ReleaseConstantsConfig();

  String get SEARCH_HISTORY;
  String get THIS_APP_NAME;
  String get EASY_LOCAL_ASSET;
  String get ASSETS_ENV;

  const ConstantsConfig._();
}

class _ReleaseConstantsConfig extends ConstantsConfig {
  const _ReleaseConstantsConfig() : super._();

  @override
  String get SEARCH_HISTORY => "search_history";

  @override
  String get THIS_APP_NAME => "com.ddate.dateapp";

  @override
  String get EASY_LOCAL_ASSET => "assets/translations";

  @override
  String get ASSETS_ENV => "assets/.env";
}