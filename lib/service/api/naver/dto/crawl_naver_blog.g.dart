// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crawl_naver_blog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CrawlNaverBlog _$CrawlNaverBlogFromJson(Map<String, dynamic> json) =>
    CrawlNaverBlog(
      desc: json['desc'] as String,
      img: (json['img'] as List<dynamic>).map((e) => e as String?).toList(),
    );

Map<String, dynamic> _$CrawlNaverBlogToJson(CrawlNaverBlog instance) =>
    <String, dynamic>{
      'desc': instance.desc,
      'img': instance.img,
    };
