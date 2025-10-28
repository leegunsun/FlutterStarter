
import 'package:freezed_annotation/freezed_annotation.dart';

import '../enum/content_type.dart';

part "blog_crawl_content.freezed.dart";
part "blog_crawl_content.g.dart";

@freezed
abstract class CrawlContent with _$CrawlContent {
  const factory CrawlContent({
    required ContentType contentType,
    required String contentValue,
  }) = _CrawlContent;

  factory CrawlContent.fromJson(Map<String, dynamic> json) =>
      _$CrawlContentFromJson(json);
}
