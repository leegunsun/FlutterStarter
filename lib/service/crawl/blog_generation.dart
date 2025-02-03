
import 'dart:convert';

import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart' hide Element;
import 'package:html/dom.dart' show Document, Element;
import 'package:html/parser.dart' as htmlParser;

import '../api/naver/dto/crawl_naver_blog.dart';
import '../api/naver/dto/search_dto.dart';
import '../api/naver/naver_api.dart';
import '../api/vertex/dto/vertext_search_dto.dart';
import 'blog_crawler.dart';

class BlogGenerationService {

  final NaverAPI _naverAPI = NaverAPI();

  final model = FirebaseVertexAI.instance.generativeModel(
      model: 'gemini-1.5-flash',
      generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
          responseSchema: Schema.object(
            description:
            "이 스키마는 데이트 장소를 원하는 연인들에게 적합한 블로그 글을 생성하는 데 사용됩니다. 각 필드는 AI가 글을 구성할 때 의도를 정확히 반영할 수 있도록 정의되었습니다.",
            properties: {
              'title': Schema.string(
                  description: "글의 제목을 나타냅니다. 핵심 주제를 간결하게 표현하는 것이 중요합니다."),
              'blogMobileLink': Schema.string(),
              'postdate': Schema.string(),
              'tag': Schema.string(
                  description: "태그는 글의 주제나 특징을 나타내는 단어로 작성해야 하며, 단어 간 띄어쓰기를 허용하지 않습니다. 태그는 쉼표(,)로 구분해야 합니다."
              ),
              'location': Schema.string(
                  description:
                  "글에서 설명하는 장소의 위치를 나타냅니다. 특정한 장소를 언급하는 경우, 지역명이나 주소 형식으로 작성될 수 있습니다."),
              'recommend': Schema.string(
                  description:
                  "이 글이 어떤 독자에게 유용한 정보를 제공하는지 나타냅니다. 예를 들어, 음식점 리뷰라면 \"맛집을 찾는 사람\" 혹은 \"현지 음식을 경험하고 싶은 여행객\" 등이 될 수 있습니다."),
              'desc': Schema.string(
                  description:
                  "글의 주요 내용을 설명하는 부분입니다. 답변을 격식있는 말투로 작성하지 마세요. 글쓴이의 말투를 유지해야합니다. 글의 흐름을 자연스럽게 이어가며 본문의 내용을 포함해야 합니다."),
            },
            optionalProperties: [
              'title',
              'blogMobileLink',
              'postdate',
              'location',
              'recommend',
              'desc'
            ],
          )));

  Future<NaverApiBlogSearchDto> searchBlogs(String query) async {
    return await _naverAPI.blogSearch.getBlogSearch(query: query);
  }

  Future<VertextSearchDto?> generateContentFromBlog(BlogSearchItems item) async {
    final BlogCrawlerService _crawler = BlogCrawlerService();
    final CrawlNaverBlog? blogContent = await _crawler.fetchBlogContent(item.blogMobileLink);

    if (blogContent == null) return null;

    final GenerateContentResponse response = await model.generateContent([Content.text(blogContent.desc)]);

    return _parseGeneratedResponse(response.text, blogContent, item);
  }

  VertextSearchDto? _parseGeneratedResponse(String? responseText, CrawlNaverBlog blogContent, BlogSearchItems item) {
    if (responseText == null) return null;

    Map<String, dynamic>? _encode;
    VertextSearchDto? _result;

    try {
      _encode = jsonDecode(responseText);

      if (_encode?["desc"] == null) {
        throw Exception("desc is null");
      }

      List<String?> _tag = (_encode?["tag"] as String).split(",").toList();

      _result = VertextSearchDto.fromJson(_encode!)
        ..blogMobileLink = item.blogMobileLink!
        ..postdate = item.postdate
        ..tag.addAll(_tag)
        ..desc = _encode["desc"].replaceAll(".", '.\n\n')
        ..img.addAll(blogContent.img)
        ..title ??= item.title;
    } catch (e) {
      print('JSON 디코딩 오류: $e');
      _encode = null;
    }

    return _result;
  }
}
