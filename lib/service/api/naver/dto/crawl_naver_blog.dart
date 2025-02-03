import 'package:json_annotation/json_annotation.dart';

part 'crawl_naver_blog.g.dart';

enum ContentType { text, image }

@JsonSerializable(explicitToJson: true)
class CrawlNaverBlog {

  final List<CrawlContent> contents;
  final String desc;

  CrawlNaverBlog({required this.contents, required this.desc});

    Map<String,dynamic> toJson () => _$CrawlNaverBlogToJson(this);
    factory CrawlNaverBlog.fromJson (Map<String,dynamic> json) => _$CrawlNaverBlogFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CrawlContent {
  final ContentType contentType;
  final String contentValue;

  CrawlContent({required this.contentType, required this.contentValue});

  Map<String,dynamic> toJson () => _$CrawlContentToJson(this);
  factory CrawlContent.fromJson (Map<String,dynamic> json) => _$CrawlContentFromJson(json);
}