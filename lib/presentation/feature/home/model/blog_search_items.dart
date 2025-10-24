import 'package:freezed_annotation/freezed_annotation.dart';

part 'blog_search_items.freezed.dart';
part 'blog_search_items.g.dart';

@freezed
abstract class BlogSearchItems with _$BlogSearchItems {

  const factory BlogSearchItems({
    required String title,
    required String link,
    String? thumnail,
    String? blogMobileLink,
    required String description,
    required String bloggername,
    required String bloggerlink,
    required String postdate,
  }) = _BlogSearchItems;

  factory BlogSearchItems.fromJson(Map<String, dynamic> json) =>
      _$BlogSearchItemsFromJson(json);
}

extension BlogSearchItemsX on BlogSearchItems {
  /// 변환된 모바일 블로그 링크 (계산된 값)
  String get computedBlogMobileLink =>
      link.replaceFirst("blog.naver.com", "m.blog.naver.com");

  /// 네이버 블로그 여부 확인
  bool get isNaverBlog => computedBlogMobileLink.contains("m.blog.naver.com");
}
