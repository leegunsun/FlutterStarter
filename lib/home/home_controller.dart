import 'package:flutter/material.dart' hide Element;

import '../service/api/naver/dto/search_dto.dart';
import '../service/api/vertex/dto/vertext_search_dto.dart';
import '../service/crawl/blog_crawler.dart';
import '../service/crawl/blog_generation.dart';

class HomeController {
  final List<VertextSearchDto?> responses = [];
  final BlogCrawlerService _blogCrawlerService = BlogCrawlerService();
  final BlogGenerationService _blogGenerationService = BlogGenerationService();

  Future<void> fetchBlogSearchResults(void Function() setState, void Function(ConnectionState) connectionState) async {
    connectionState(ConnectionState.waiting);

    // 네이버 블로그 검색
    NaverApiBlogSearchDto _result = await _blogGenerationService.searchBlogs("송파+데이트");

    for (BlogSearchItems item in _result.items.where((item) => item.isNaverBlog)) {
      VertextSearchDto? generatedContent = await _blogGenerationService.generateContentFromBlog(item);
      responses.add(generatedContent);
    }

    connectionState(ConnectionState.done);
    setState();
  }
}