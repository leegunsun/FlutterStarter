part of '../environment_config.dart';

class _DebugEnvConfig extends EnvConfig {
  const _DebugEnvConfig() : super._();

  @override
  String get X_Naver_Client_Id => dotenv.env['NAVER_CLIENT_ID'] ?? '';
  @override
  String get X_Naver_Client_Secret => dotenv.env['NAVER_CLIENT_SECRET'] ?? '';
  @override
  String get APPS_FLYER_DEV_KEY => dotenv.env['APPS_FLYER_DEV_KEY'] ?? '';
}