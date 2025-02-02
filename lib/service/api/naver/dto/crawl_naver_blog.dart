import 'package:json_annotation/json_annotation.dart';

part 'crawl_naver_blog.g.dart';

@JsonSerializable(explicitToJson: true)
class CrawlNaverBlog {

  final String desc;
  final List<String?> img;

  CrawlNaverBlog({required this.desc, required this.img});

    Map<String,dynamic> toJson () => _$CrawlNaverBlogToJson(this);
    factory CrawlNaverBlog.fromJson (Map<String,dynamic> json) => _$CrawlNaverBlogFromJson(json);
}
