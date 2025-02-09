part of '../environment_config.dart';

abstract class ApiConfig {

  static final _instance = kDebugMode ? _DebugApiConfig() : _ApiReleaseConfig();

  String get naverApi;
  String get fcmApi;

  const ApiConfig._();
}

class _ApiReleaseConfig extends ApiConfig {
  const _ApiReleaseConfig() : super._();

  @override
  String get naverApi => "https://openapi.naver.com/";

  @override
  get fcmApi => "https://sendpushnotification-tzvcof2hmq-uc.a.run.app";
}