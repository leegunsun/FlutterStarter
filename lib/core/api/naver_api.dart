
import 'package:dateapp/config/environment.dart';
import 'package:dio/dio.dart';

import '../base/api_base.dart';
import '../repositories/naver/blog_search.dart';


class NaverAPI extends ApiBase {
  static final NaverAPI _instance = NaverAPI._internal();

  factory NaverAPI() => _instance;

  NaverAPI._internal() : super(dio: Dio(
    BaseOptions(
      baseUrl: "https://openapi.naver.com/",
      connectTimeout: const Duration(milliseconds: 60000),
      receiveTimeout: const Duration(milliseconds: 60000),
      sendTimeout: const Duration(milliseconds: 60000),
      responseType: ResponseType.json,
      headers: {
        "X-Naver-Client-Id" : Environment.X_Naver_Client_Id,
        "X-Naver-Client-Secret" : Environment.X_Naver_Client_Secret,
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