import 'package:dateapp/presentation/feature/home/model/blog_crawl_content.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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