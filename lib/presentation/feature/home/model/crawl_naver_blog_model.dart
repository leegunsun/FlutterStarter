import 'package:freezed_annotation/freezed_annotation.dart';

import '../enum/content_type.dart';

part 'crawl_naver_blog_model.freezed.dart';
part 'crawl_naver_blog_model.g.dart';

@freezed
abstract class CrawlNaverBlogModel with _$CrawlNaverBlogModel {
  const factory CrawlNaverBlogModel({
    required List<CrawlContent> imgContents,
    required String desc,
  }) = _CrawlNaverBlogModel;

  factory CrawlNaverBlogModel.fromJson(Map<String, dynamic> json) =>
      _$CrawlNaverBlogModelFromJson(json);
}

@freezed
abstract class CrawlContent with _$CrawlContent {
  const factory CrawlContent({
    required ContentType contentType,
    required String contentValue,
  }) = _CrawlContent;

  factory CrawlContent.fromJson(Map<String, dynamic> json) =>
      _$CrawlContentFromJson(json);
}