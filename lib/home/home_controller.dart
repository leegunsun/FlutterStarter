import 'package:flutter/material.dart' hide Element;

import '../service/api/naver/dto/search_dto.dart';
import '../service/api/vertex/dto/vertext_search_dto.dart';
import '../service/crawl/blog_crawler.dart';
import '../service/crawl/blog_generation.dart';

class HomeController {
  final List<VertextSearchDto?> aiResponses = [];
  final List<BlogSearchItems?> blogResponses = [];
  // final BlogCrawlerService _blogCrawlerService = BlogCrawlerService();
  final BlogGenerationService _blogGenerationService = BlogGenerationService();

  Future<void> fetchBlogSearchResults(void Function() setState, void Function(ConnectionState) connectionState) async {
    connectionState(ConnectionState.waiting);

    // 네이버 블로그 검색
    NaverApiBlogSearchDto _result = await _blogGenerationService.searchBlogs("문정역+맛집");
    blogResponses.addAll(_result.items);

    // 'isNaverBlog' 조건을 만족하는 아이템 필터링 후 랜덤으로 2개 선택
    List<BlogSearchItems> filteredItems = _result.items.where((item) => item.isNaverBlog).toList();
    filteredItems.shuffle(); // 무작위로 섞기
    Iterable<BlogSearchItems> selectedItems = filteredItems.take(2); // 2개 선택

    try {
      // 병렬 실행 + 결과 즉시 responses에 추가
      aiResponses.addAll(await Future.wait(selectedItems.map(_blogGenerationService.generateContentFromBlog)));
    } catch (e) {
      // 예외 발생 시 로그 남기기 (필요하면 예외 처리 방식 추가)
      print("블로그 컨텐츠 생성 중 오류 발생: $e");
    }

    connectionState(ConnectionState.done);
    setState();
  }
}