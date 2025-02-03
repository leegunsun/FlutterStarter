
import 'package:dio/dio.dart';

/// API 서비스의 공통 부모 클래스
abstract class BaseApiService {
  final Dio api;

  BaseApiService({required Dio dio})
      : api = dio {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    print("인터셉터 설정");
    api.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {

        if(options.headers['test11'] == true) {
          print("test11 헤더가 이미 존재합니다.");
          options.headers['test11'] = 'true';
        }

        print('Request: ${options.method} ${options.path}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('Response: ${response.statusCode} ${response.statusMessage}');
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        print('Error: ${e.message}');
        return handler.next(e);
      },
    ));
  }
}
