import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dateapp/core/base/controller/widget_textcontroller_base.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart' hide Element;

import '../../core/models/naver/search_model.dart';
import '../../core/models/vertex/vertex_search_model.dart';
import '../../core/service/crawl/blog_generation_service.dart';

class HomeViewModel extends BaseWidgetTextController {
  final List<VertexSearchModel?> aiResponses = [];
  final List<BlogSearchItems?> blogResponses = [];
  final PageController pageController = PageController(viewportFraction: 0.8);
  final PageController pageController2 = PageController(viewportFraction: 0.9);

  @override
  final TextEditingController textEditingController = TextEditingController(text: "문정역 맛집");

  // final BlogCrawlerService _blogCrawlerService = BlogCrawlerService();
  final BlogGenerationService _blogGenerationService = BlogGenerationService();

  final remoteConfig = FirebaseRemoteConfig.instance;

  Future<List<VertexSearchModel>> getRandomDocs() async {
    final collectionRef = FirebaseFirestore.instance.collection("aiParserData");

    // Firestore에 저장된 전체 문서 개수 가져오기
    QuerySnapshot allDocsSnapshot = await collectionRef.get();
    int docCount = allDocsSnapshot.docs.length;

    if (docCount == 0) {
      return []; // Firestore에 문서가 없으면 빈 리스트 반환
    }

    // startIndex를 전체 문서 개수 내에서만 랜덤하게 설정
    final random = Random();
    final startIndex = random.nextInt(docCount); // 0 ~ (docCount - 1) 사이의 값 설정

    // Firestore에서 무작위 시작점부터 5개 문서 가져오기
    QuerySnapshot<Map<String,dynamic>> querySnapshot = await collectionRef
        .orderBy(FieldPath.documentId) // 문서 ID 기준 정렬
        .startAtDocument(allDocsSnapshot.docs[startIndex]) // 랜덤 시작 위치
        .limit(5)
        .get();

    // return querySnapshot.docs;

    List<QueryDocumentSnapshot<Map<String, dynamic>>> _doc = querySnapshot.docs;
    List<VertexSearchModel> _result = _doc.map((QueryDocumentSnapshot<Map<String, dynamic>> e) {
      Map<String, dynamic> data = e.data();

      Map<String, dynamic> _key1 = e.data().remove('tag');

      data['tag'] = (_key1["tag"] as List<dynamic>).join(",");

      dynamic removedData = e.data().remove('crawlContent')['crawlContent'];

      data['crawlContent'] = (removedData as List)
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();

      return VertexSearchModel.fromJson(data);
    }).toList();

    return _result;
  }

  Future<void> fetchBlogSearchResults(void Function() setState,
      void Function(ConnectionState) connectionState) async {
    connectionState(ConnectionState.waiting);

    // 네이버 블로그 검색
    String _qury = textEditingController.text.replaceAll(" ", "+");
    NaverApiBlogSearchModel _result = await _blogGenerationService.searchBlogs(_qury);
    // ImgSearchDto _a = await _naverAPI.blogSearch.getBlogImgSearch(query:"테스트");

    blogResponses.addAll(_result.items);

    // 'isNaverBlog' 조건을 만족하는 아이템 필터링 후 랜덤으로 2개 선택
    List<BlogSearchItems> filteredItems = _result.items.where((item) => item.isNaverBlog).toList();
    filteredItems.shuffle(); // 무작위로 섞기
    Iterable<BlogSearchItems> selectedItems = filteredItems.take(2); // 2개 선택

    try {
      // 병렬 실행 + 결과 즉시 responses에 추가
      aiResponses.addAll(await Future.wait(selectedItems.map(_blogGenerationService.generateContentFromBlog)));
      aiResponses.addAll(await getRandomDocs());
    } catch (e) {
      // 예외 발생 시 로그 남기기 (필요하면 예외 처리 방식 추가)
      print("블로그 컨텐츠 생성 중 오류 발생: $e");
    }

    try {
      for (VertexSearchModel item in aiResponses.whereType<VertexSearchModel>()) {
        String safeDocId = base64Encode(utf8.encode(item.blogMobileLink!)); // Base64 인코딩
        FirebaseFirestore.instance.collection("aiParserData").doc(safeDocId).set(item.toJson());
      }

    } catch (e) {
      print(e);
    }

    connectionState(ConnectionState.done);
    setState();
  }
}
