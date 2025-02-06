import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'dto/img_search_dto.dart';
import 'dto/search_dto.dart';

part 'blog_search.g.dart';

@RestApi()
abstract class BlogSearchRestClient {
  factory BlogSearchRestClient(Dio dio, {String? baseUrl}) = _BlogSearchRestClient;

  @GET("v1/search/blog.json")
  Future<NaverApiBlogSearchDto> getBlogSearch({@Query("query") String? query, @Query("display") int display = 3});

  @GET("v1/search/image")
  Future<ImgSearchDto> getBlogImgSearch({@Query("query") String? query, @Query("display") int display = 1});
}