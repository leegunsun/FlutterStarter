import 'package:json_annotation/json_annotation.dart';

import '../../created_enum/content_type.dart';

part "crawl_naver_blog_model.g.dart";

@JsonSerializable(explicitToJson: true)
class CrawlNaverBlogModel {

  final List<CrawlContent> imgContents;
  final String desc;

  CrawlNaverBlogModel({required this.imgContents, required this.desc});

    Map<String,dynamic> toJson () => _$CrawlNaverBlogModelToJson(this);
    factory CrawlNaverBlogModel.fromJson (Map<String,dynamic> json) => _$CrawlNaverBlogModelFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CrawlContent {
  final ContentType contentType;
  final String contentValue;

  CrawlContent({required this.contentType, required this.contentValue});

  Map<String,dynamic> toJson () => _$CrawlContentToJson(this);
  factory CrawlContent.fromJson (Map<String,dynamic> json) => _$CrawlContentFromJson(json);
}