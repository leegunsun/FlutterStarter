import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../naver/crawl_naver_blog_model.dart';



part 'vertex_search_model.g.dart';

// @JsonEnum(alwaysCreate: true)
enum BlogCategory {
  FOOD(Icons.restaurant),          // 맛집 추천
  CAFE(Icons.local_cafe),          // 카페 추천
  DATE(Icons.favorite),            // 데이트 장소 추천
  TRAVEL(Icons.flight),            // 여행지 추천
  ACTIVITY(Icons.directions_run),  // 체험/액티비티 추천
  CULTURE(Icons.theaters),         // 문화/전시/공연 추천
  NIGHTLIFE(Icons.nightlife),      // 바, 라운지, 클럽 등 야간 데이트 장소 추천
  OUTDOOR(Icons.park),             // 공원, 산책로 등 야외 장소 추천
  SHOPPING(Icons.shopping_bag),    // 쇼핑 장소 추천
  STAY(Icons.hotel),               // 호텔, 숙박 추천
  EVENT(Icons.event),              // 축제, 행사, 시즌별 이벤트 추천
  PET_FRIENDLY(Icons.pets),        // 반려동물 동반 가능 장소
  LUXURY(Icons.local_play),        // 고급 레스토랑, 프리미엄 서비스 추천
  BUDGET(Icons.attach_money);      // 가성비 좋은 데이트 장소 추천

  const BlogCategory(this.icon);

  final IconData icon;
}

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

  Map<String, dynamic> toJson() => _$VertextSearchDtoToJson(this);

  factory VertexSearchModel.fromJson(Map<String, dynamic> json) =>
      _$VertextSearchDtoFromJson(json);
}
