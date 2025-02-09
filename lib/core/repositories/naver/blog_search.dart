import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';


import '../../models/naver/img_search_model.dart';
import '../../models/naver/search_model.dart';

part 'blog_search.g.dart';

@RestApi()
abstract class BlogSearchRestClient {
  factory BlogSearchRestClient(Dio dio, {String? baseUrl}) = _BlogSearchRestClient;

  @GET("v1/search/blog.json")
  Future<NaverApiBlogSearchModel> getBlogSearch({@Query("query") String? query, @Query("display") int display = 3});

  @GET("v1/search/image")
  Future<ImgSearchModel> getBlogImgSearch({@Query("query") String? query, @Query("display") int display = 1});
}