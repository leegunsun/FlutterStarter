import 'package:dio/dio.dart';
import 'package:html/dom.dart' show Document, Element;
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
    Document document = htmlParser.parse(html);
    Element? contentElement = document.querySelector('.se-main-container');

    if (contentElement != null) {
      String cleanedText = contentElement.text
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim();

      List<String> extractedUrls = document
          .querySelectorAll('img[data-lazy-src]')
          .map((img) => img.attributes['data-lazy-src'] ?? '')
          .where((url) => url.isNotEmpty)
          .toList();

      return CrawlNaverBlog(desc: cleanedText, img: extractedUrls);
    }
    return null;
  }
}
