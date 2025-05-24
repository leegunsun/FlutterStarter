part of '../environment_config.dart';

class _DebugConstantsConfig extends ConstantsConfig {
  const _DebugConstantsConfig() : super._();

  @override
  String get SEARCH_HISTORY => "search_history";

  @override
  String get THIS_APP_NAME => "com.ddate.dateapp";

  @override
  String get EASY_LOCAL_ASSET => "assets/translations";

  @override
  String get ASSETS_ENV => "assets/.env";

  @override
  String get SEARCH_LAST_INPUT_HISTORY => "search_last_input_history";
}