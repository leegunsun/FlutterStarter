// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NaverApiBlogSearchDto _$NaverApiBlogSearchDtoFromJson(
        Map<String, dynamic> json) =>
    NaverApiBlogSearchDto(
      lastBuildDate: json['lastBuildDate'] as String,
      total: json['total'] as num,
      start: json['start'] as num,
      display: json['display'] as num,
      items: (json['items'] as List<dynamic>)
          .map((e) => BlogSearchItems.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NaverApiBlogSearchDtoToJson(
        NaverApiBlogSearchDto instance) =>
    <String, dynamic>{
      'lastBuildDate': instance.lastBuildDate,
      'total': instance.total,
      'start': instance.start,
      'display': instance.display,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

BlogSearchItems _$BlogSearchItemsFromJson(Map<String, dynamic> json) =>
    BlogSearchItems(
      title: json['title'] as String,
      link: json['link'] as String,
      description: json['description'] as String,
      bloggername: json['bloggername'] as String,
      bloggerlink: json['bloggerlink'] as String,
      postdate: json['postdate'] as String,
      thumnail: json['thumnail'] as String?,
    );

Map<String, dynamic> _$BlogSearchItemsToJson(BlogSearchItems instance) =>
    <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
      'thumnail': instance.thumnail,
      'description': instance.description,
      'bloggername': instance.bloggername,
      'bloggerlink': instance.bloggerlink,
      'postdate': instance.postdate,
    };
