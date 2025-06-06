
import 'dart:convert';

import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:collection/collection.dart';

import '../../models/naver/blog_search_items.dart';
import '../../models/naver/crawl_naver_blog_model.dart';
import '../../models/naver/img_search_model.dart';
import '../../models/naver/search_model.dart';
import '../../api/naver/naver_api.dart';
import '../../models/vertex/vertex_search_model.dart';
import 'blog_crawler_service.dart';

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
              'blogMobileLink': Schema.string(
                  description: "해당 글을 모바일 환경에서 확인 할 수 있는 url을 나타냅니다.",
              ),
              'postdate': Schema.string(),
              'tag': Schema.string(
                  description: "태그는 글의 주제나 특징을 나타내는 단어로 작성해야 하며, 단어 간 띄어쓰기를 허용하지 않습니다. 태그는 쉼표(,)로 구분해야 합니다."
              ),
              'location': Schema.string(
                  description:
                  "글에서 설명하는 장소의 위치를 나타냅니다. 한국의 주소 체계를 따르는 주소를 생성해 주세요. 주소 형식은 \'[광역시/도] [시/군/구] [도로명] [건물번호]\' 형태로 구성해 주세요. 도로명 주소를 기반으로 하고, 한국에서 일반적으로 사용되는 실제적인 형태의 주소를 출력해 주세요."),
              'recommend': Schema.string(
                  description:
                  "이 글이 어떤 독자에게 유용한 정보를 제공하는지 나타냅니다. 예를 들어, 음식점 리뷰라면 \"맛집을 찾는 사람\" 혹은 \"현지 음식을 경험하고 싶은 여행객\" 등이 될 수 있습니다."),
              'desc': Schema.string(
                  description:
                  "글의 주요 내용을 설명하는 부분입니다. 답변을 격식있는 말투로 작성하지 마세요. 글의 흐름을 자연스럽게 이어가며 본문의 내용을 포함해야 합니다."),
              'category': Schema.enumString(
                enumValues: [
                  'FOOD', 'CAFE', 'DATE', 'TRAVEL', 'ACTIVITY',
                  'CULTURE', 'NIGHTLIFE', 'OUTDOOR', 'SHOPPING',
                  'STAY', 'EVENT', 'PET_FRIENDLY', 'LUXURY', 'BUDGET'
                ],
                description: "AI가 생성한 글의 카테고리를 나타냅니다. 카테고리 분류는 '생성한 글의 내용'과 '생성한 태그'로 판단해야 합니다.",
              ),
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

  String removeHtmlTags(String htmlText) {
    final RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);
    return htmlText.replaceAll(exp, '');
  }

  Future<NaverApiBlogSearchModel> searchBlogs(String query) async {
    // 기본 블로그 검색 수행
    NaverApiBlogSearchModel _baseResult = await _naverAPI.blogSearch.getBlogSearch(query: query);

    List<ImgSearchModel?> _imgSearchResponse = await Future.wait(
      _baseResult.items.map((searchItem) =>
          _naverAPI
              .blogSearch
              .getBlogImgSearch(query: removeHtmlTags(searchItem.title).replaceAll(" ", "+"))
      ),
    );

    final List<BlogSearchItems> updatedItems = _baseResult.items
        .mapIndexed((int i, BlogSearchItems item) => item.copyWith(
      thumnail: _imgSearchResponse[i]?.items.firstOrNull?.link,
      blogMobileLink : item.blogMobileLink ?? item.link,
    )).toList();

    return _baseResult.copyWith(items: updatedItems);
  }


  Future<VertexSearchModel?> generateContentFromBlog(BlogSearchItems item) async {
    final BlogCrawlerService _crawler = BlogCrawlerService();
    final CrawlNaverBlogModel? blogContent = await _crawler.fetchBlogContent(item.blogMobileLink);

    if (blogContent == null) return null;

    final GenerateContentResponse response = await model.generateContent([Content.text(blogContent.desc)]);

    return _parseGeneratedResponse(response.text, blogContent, item);
  }

  VertexSearchModel? _parseGeneratedResponse(String? responseText, CrawlNaverBlogModel blogContent, BlogSearchItems item) {
    if (responseText == null) return null;

    Map<String, dynamic>? _encode;
    VertexSearchModel? _result;

    try {
      _encode = jsonDecode(responseText);

      if (_encode?["desc"] == null) {
        throw Exception("desc is null");
      }

      List<String?> _tag = (_encode?["tag"] as String).split(",").toList();
      String _desc = _encode?["desc"];
      _encode?["crawlContent"] = blogContent.imgContents.map((e) => e.toJson()).toList();

      _result = VertexSearchModel.fromJson(_encode!)
        ..blogMobileLink = item.blogMobileLink!
        ..postdate = item.postdate
        ..tag.addAll(_tag)
        ..desc = _desc.replaceAllMapped(
            RegExp(r'([!@.?])'), // 특수 문자 패턴
                (match) => '${match.group(1)}\n\n' // 특수 문자 유지 + 개행 추가
        )
        ..title ??= item.title;
    } catch (e) {
      print('JSON 디코딩 오류: $e');
      _encode = null;
    }

    return _result;
  }
}