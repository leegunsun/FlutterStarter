import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  final remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> fetchBlogSearchResults(void Function() setState,
      void Function(ConnectionState) connectionState) async {
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

    try {
      for (VertextSearchDto item in aiResponses.whereType<VertextSearchDto>()) {
        String safeDocId = base64Encode(utf8.encode(item.blogMobileLink!)); // Base64 인코딩
        FirebaseFirestore.instance.collection("aiParserData").doc(safeDocId).set(item.toJson());
      }
      print("");
    } catch (e) {
      print(e);
    }

    connectionState(ConnectionState.done);
    setState();
  }
}
