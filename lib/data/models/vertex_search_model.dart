import 'package:dateapp/core/api/naver_api.dart';
import 'package:json_annotation/json_annotation.dart';

import '../enum/blog_category.dart';
import 'crawl_naver_blog_model.dart';

part 'vertex_search_model.g.dart';


@JsonSerializable(explicitToJson: true)
class VertexSearchModel {

  @JsonKey(fromJson: validateNonEmptyString, toJson: identityFunction)
  String? title;

  String? blogMobileLink;

  @JsonKey(fromJson: validateNonEmptyString, toJson: identityFunction)
  String? postdate;

  @JsonKey(fromJson: _crawlContentFromJson, toJson: _crawlContentToJson) // 추가
  final List<CrawlContent?> crawlContent;

  @JsonKey(fromJson: validateNonEmptyString, toJson: identityFunction)
  final String? location;

  @JsonKey(fromJson: validateNonEmptyString, toJson: identityFunction)
  final String? recommend;

  @JsonKey(fromJson: _crawlTagFromJson, toJson: _crawlTagToJson)
  final List<String?> tag;

  @JsonKey(fromJson: validateNonEmptyString, toJson: identityFunction)
  String? desc;

  BlogCategory category;

  VertexSearchModel({
    required this.title,
    required this.blogMobileLink,
    required this.postdate,
    required this.location,
    required this.recommend,
    required this.desc,
    required this.category,
    this.tag = const [],  // 기본값 설정
    this.crawlContent = const [], // 기본값 설정
  });

  static Map<String, List<Map<String, dynamic>?>> _crawlContentToJson(List<CrawlContent?> list) => {
    'crawlContent': list.map((e) => e?.toJson()).toList(),
  };
  static List<CrawlContent> _crawlContentFromJson(List<Map<String, dynamic>?> list) => list.whereType<Map<String, dynamic>>().map((e) => CrawlContent.fromJson(e)).toList();

  static List<String?> _crawlTagFromJson(String? value) {
    return value?.split(",") ?? [];
  }

  static Map<String, dynamic> _crawlTagToJson(List<String?> value) {
    return {
      'tag': value,
    };
  }

  // 공백 및 빈 문자열을 검증하는 함수
  static String? identityFunction(String? value) => value;

  // 공백 및 빈 문자열을 검증하는 함수
  static String? validateNonEmptyString(String? value) {

    if (value == null || value.trim().isEmpty || value.toLowerCase() == 'string') {
      return null;
    }

    return value;
  }

  Map<String, dynamic> toJson() => _$VertexSearchModelToJson(this);

  factory VertexSearchModel.fromJson(Map<String, dynamic> json) =>
      _$VertexSearchModelFromJson(json);
}
