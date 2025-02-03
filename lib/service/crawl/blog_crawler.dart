import 'package:dio/dio.dart';
import 'package:html/dom.dart' show Document, Element, Node;
import 'package:html/parser.dart' as htmlParser;

import '../api/naver/dto/crawl_naver_blog.dart';

class BlogCrawlerService {
  final Dio _dio = Dio(BaseOptions(headers: {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
  }));

  Future<CrawlNaverBlog?> fetchBlogContent(String? url) async {
    if (url == null) {
      throw Exception("URL이 null입니다.");
    }

    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        return _parseHtml(response.data);
      }
    } catch (e) {
      print('블로그 크롤링 오류: $e');
    }
    return null;
  }


  CrawlNaverBlog? _parseHtml(String html) {
    // HTML 파싱 및 콘텐츠 영역 선택
    Document document = htmlParser.parse(html);
    Element? contentElement = document.querySelector('.se-main-container');
    if (contentElement == null) return null;

    List<CrawlContent> contents = [];

    // 재귀 함수를 통해 노드 순회 (깊이 우선 탐색)
    void traverse(Node node) {
      // 1단계: 텍스트 노드 처리
      if (node.nodeType == Node.TEXT_NODE) {
        String text = node.text?.trim() ?? '';
        if (text.isNotEmpty) {
          contents.add(CrawlContent(contentType: ContentType.text, contentValue: text));
        }
      }
      // 2단계: Element 처리
      else if (node is Element) {
        // 이미지 요소 처리
        if (node.localName == 'img' && node.attributes.containsKey('data-lazy-src')) {
          String imageUrl = node.attributes['data-lazy-src'] ?? '';
          if (imageUrl.isNotEmpty) {
            contents.add(CrawlContent(contentType: ContentType.image, contentValue: imageUrl));
          }
        }
        // 이미지 외의 요소는 자식 노드를 순회
        else {
          for (var child in node.nodes) {
            traverse(child);
          }
        }
      }
    }

    // 콘텐츠 영역의 최상위 노드부터 재귀 순회 시작
    traverse(contentElement);

    // 추출된 텍스트들을 하나의 정리된 문자열로 결합
    String cleanedText = contents
        .where((item) => item.contentType == ContentType.text)
        .map((item) => item.contentValue)
        .join(' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    return CrawlNaverBlog(contents: contents, desc: cleanedText);
  }

}
