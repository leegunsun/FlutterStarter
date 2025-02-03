
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../base_api_service.dart';
import 'blog_search.dart';

class NaverAPI extends BaseApiService {

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
        "X-Naver-Client-Id" : dotenv.env["NAVER_CLIENT_ID"],
        "X-Naver-Client-Secret" : dotenv.env["NAVER_CLIENT_SECRET"],
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