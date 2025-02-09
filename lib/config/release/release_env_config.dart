part of '../environment_config.dart';

abstract class EnvConfig {
  static final EnvConfig _instance = kDebugMode ? _DebugEnvConfig() : _ReleaseEnvConfig();

  // 부모 클래스에서 getter를 정의
  String get X_Naver_Client_Id;
  String get X_Naver_Client_Secret;
  String get APPS_FLYER_DEV_KEY;

  const EnvConfig._();
}

class _ReleaseEnvConfig extends EnvConfig {
  const _ReleaseEnvConfig() : super._();
 
  String get X_Naver_Client_Id => dotenv.env['NAVER_CLIENT_ID'] ?? '';
  String get X_Naver_Client_Secret => dotenv.env['NAVER_CLIENT_SECRET'] ?? '';
  String get APPS_FLYER_DEV_KEY => dotenv.env['APPS_FLYER_DEV_KEY'] ?? '';
}