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

_CrawlContent _$CrawlContentFromJson(Map<String, dynamic> json) =>
    _CrawlContent(
      contentType: $enumDecode(_$ContentTypeEnumMap, json['contentType']),
      contentValue: json['contentValue'] as String,
    );

Map<String, dynamic> _$CrawlContentToJson(_CrawlContent instance) =>
    <String, dynamic>{
      'contentType': _$ContentTypeEnumMap[instance.contentType]!,
      'contentValue': instance.contentValue,
    };

const _$ContentTypeEnumMap = {
  ContentType.text: 'text',
  ContentType.image: 'image',
};
