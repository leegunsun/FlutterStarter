// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crawl_naver_blog_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CrawlNaverBlogModel _$CrawlNaverBlogModelFromJson(Map<String, dynamic> json) =>
    _CrawlNaverBlogModel(
      imgContents: (json['imgContents'] as List<dynamic>)
          .map((e) => CrawlContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      desc: json['desc'] as String,
    );

Map<String, dynamic> _$CrawlNaverBlogModelToJson(
  _CrawlNaverBlogModel instance,
) => <String, dynamic>{
  'imgContents': instance.imgContents,
  'desc': instance.desc,
};
