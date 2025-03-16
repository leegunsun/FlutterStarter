
import 'package:dateapp/config/environment_config.dart';
import 'package:dio/dio.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../navigation/navigation_manager.dart';

/// API 서비스의 공통 부모 클래스
abstract class ApiBase {
  final Dio api;

  ApiBase({required Dio dio}) : api = dio {
    _setupInterceptors();
  }

  HttpMethod _convertMethod(String reqMethod) {
    return HttpMethod.values
        .firstWhere((ele) => ele.name.toUpperCase() == reqMethod.toUpperCase());
  }

  void _setupInterceptors() {
    print("인터셉터 설정");
    api.interceptors.add(InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        HttpMethod _method = _convertMethod(options.method);

        final HttpMetric metric = FirebasePerformance.instance
            .newHttpMetric(options.uri.toString(), _method);

        metric.requestPayloadSize = options.data?.toString().length;

        await metric.start();

        options.extra['httpMetric'] = metric;
        metric.putAttribute('scoreTEST', '515');
        if (options.headers['test11'] == true) {
          print("test11 헤더가 이미 존재합니다.");
          options.headers['test11'] = 'true';
        }

        print('Request: ${options.method} ${options.path}');
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        final HttpMetric? metric = response.requestOptions.extra['httpMetric'];

        String _getFirebaseState =
            FirebaseRemoteConfig.instance.getString("close_server");
        bool? _closedServer = bool.tryParse(_getFirebaseState);

        if (_closedServer != null && _closedServer) {
          NavigationManager.router.goNamed(AppRoutes.serverDown);
          return;
        }

        if (metric != null) {
          metric.responseContentType = response.headers.value('content-type');
          metric.httpResponseCode = response.statusCode;
          metric.responsePayloadSize = response.data?.toString().length;
          metric.putAttribute('score', '15');
          metric.putAttribute('to_be_removed', 'should_not_be_logged');

          metric.removeAttribute('to_be_removed');
          await metric.stop();

          final attributes = metric.getAttributes();
          print('Http metric attributes: $attributes.');

          String? score = metric.getAttribute('score');
          print('Http metric score attribute value: $score');
        }

        print('Response: ${response.statusCode} ${response.statusMessage}');
        return handler.next(response);
      },
      onError: (DioException err, handler) async {
        final HttpMetric? metric = err.requestOptions.extra['httpMetric'];

        try {
          if (metric != null) {
            metric.httpResponseCode = err.response?.statusCode ?? 500;
            metric.putAttribute('error', err.response?.data);
          }
        } catch (e) {
          print(e);
        } finally {
          if (metric != null) {
            await metric.stop();
          }
        }

        print('Error: ${err.message}');
        return handler.next(err);
      },
    ));
  }
}
