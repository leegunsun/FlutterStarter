
import 'package:dateapp/config/environment_config.dart';
import 'package:dio/dio.dart';

import '../../base/api/api_base.dart';
import 'repositories/blog_search.dart';


class NaverAPI extends ApiBase {
  NaverAPI() : super(dio: Dio(
    BaseOptions(
      baseUrl: EnvironmentConfig.api.naverApi,
      connectTimeout: const Duration(milliseconds: 60000),
      receiveTimeout: const Duration(milliseconds: 60000),
      sendTimeout: const Duration(milliseconds: 60000),
      responseType: ResponseType.json,
      headers: {
        "X-Naver-Client-Id" : EnvironmentConfig.env.X_Naver_Client_Id,
        "X-Naver-Client-Secret" : EnvironmentConfig.env.X_Naver_Client_Secret,
      },
    ),
  )) {
    _init();
  }

  late final BlogSearchRestClient blogSearch;

  void _init() {
    blogSearch = BlogSearchRestClient(api);
  }
}

//adb shell pm list packages | grep "com.google.android.gms"