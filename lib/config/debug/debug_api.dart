part of '../environment_config.dart';

class _DebugApiConfig extends ApiConfig {
  const _DebugApiConfig() : super._();

  @override
  String get naverApi => "https://openapi.naver.com/";

  @override
  get fcmApi => "https://sendpushnotification-tzvcof2hmq-uc.a.run.app";

}