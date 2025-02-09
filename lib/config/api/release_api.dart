part of '../environment_config.dart';

abstract class _ApiConfig {

  get naverApi => UnimplementedError();
  get fcmApi => UnimplementedError();
}

class _ApiReleaseConfig extends EnvironmentConfig implements _ApiConfig {

  @override
  String get naverApi => "https://openapi.naver.com/";

  @override
  get fcmApi => "https://sendpushnotification-tzvcof2hmq-uc.a.run.app";
}