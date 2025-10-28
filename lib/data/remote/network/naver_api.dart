
import 'package:dio/dio.dart';

import '../../../app/config/environment_config.dart';
import '../repository/blog_search.dart';
import 'api_base.dart';


class NaverAPI extends ApiBase {
  late final BlogSearchRestClient blogSearch;

  factory NaverAPI() {
    final instance = NaverAPI._internal();
    instance.blogSearch = BlogSearchRestClient(instance.api);
    return instance;
  }

  NaverAPI._internal()
      : super(
    dio: Dio(
      BaseOptions(
        baseUrl: EnvironmentConfig.api.naverApi,
        connectTimeout: const Duration(milliseconds: 60000),
        receiveTimeout: const Duration(milliseconds: 60000),
        sendTimeout: const Duration(milliseconds: 60000),
        responseType: ResponseType.json,
        headers: {
          "X-Naver-Client-Id": EnvironmentConfig.env.X_Naver_Client_Id,
          "X-Naver-Client-Secret": EnvironmentConfig.env.X_Naver_Client_Secret,
        },
      ),
    ),
  );
}

//adb shell pm list packages | grep "com.google.android.gms"