import 'package:dateapp/core/base/api/api_base.dart';
import 'package:dateapp/core/models/appstate/appstate_model.dart';
import 'package:dio/dio.dart';

class StatusApi extends ApiBase {
  StatusApi() : super(dio: Dio(
    BaseOptions(
      baseUrl: "",
      connectTimeout: const Duration(milliseconds: 60000),
      receiveTimeout: const Duration(milliseconds: 60000),
      sendTimeout: const Duration(milliseconds: 60000),
      responseType: ResponseType.json,
    ),
  ));

  Future<AppStatus> mockResult () async {
    return Future.delayed(Duration(seconds: 1), () {
      return AppStatus(currentVersion: "1.0.1", isForcedUpdate:  true, isServerMaintenance: false);
    });
  }
}