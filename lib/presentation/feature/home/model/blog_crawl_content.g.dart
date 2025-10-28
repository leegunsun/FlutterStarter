// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_crawl_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
