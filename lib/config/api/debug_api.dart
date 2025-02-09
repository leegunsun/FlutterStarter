part of '../environment_config.dart';

class _ApiDebugConfig extends EnvironmentConfig implements _ApiConfig {

  @override
  String get naverApi => "https://openapi.naver.com/";

  @override
  get fcmApi => "https://sendpushnotification-tzvcof2hmq-uc.a.run.app";

}