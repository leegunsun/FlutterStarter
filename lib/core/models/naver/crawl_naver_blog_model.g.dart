// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crawl_naver_blog_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CrawlNaverBlogModel _$CrawlNaverBlogModelFromJson(Map<String, dynamic> json) =>
    CrawlNaverBlogModel(
      imgContents: (json['imgContents'] as List<dynamic>)
          .map((e) => CrawlContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      desc: json['desc'] as String,
    );

Map<String, dynamic> _$CrawlNaverBlogModelToJson(
        CrawlNaverBlogModel instance) =>
    <String, dynamic>{
      'imgContents': instance.imgContents.map((e) => e.toJson()).toList(),
      'desc': instance.desc,
    };

CrawlContent _$CrawlContentFromJson(Map<String, dynamic> json) => CrawlContent(
      contentType: $enumDecode(_$ContentTypeEnumMap, json['contentType']),
      contentValue: json['contentValue'] as String,
    );

Map<String, dynamic> _$CrawlContentToJson(CrawlContent instance) =>
    <String, dynamic>{
      'contentType': _$ContentTypeEnumMap[instance.contentType]!,
      'contentValue': instance.contentValue,
    };

const _$ContentTypeEnumMap = {
  ContentType.text: 'text',
  ContentType.image: 'image',
};
