// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_search_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BlogSearchItems _$BlogSearchItemsFromJson(Map<String, dynamic> json) =>
    _BlogSearchItems(
      title: json['title'] as String,
      link: json['link'] as String,
      thumnail: json['thumnail'] as String?,
      blogMobileLink: json['blogMobileLink'] as String?,
      description: json['description'] as String,
      bloggername: json['bloggername'] as String,
      bloggerlink: json['bloggerlink'] as String,
      postdate: json['postdate'] as String,
    );

Map<String, dynamic> _$BlogSearchItemsToJson(_BlogSearchItems instance) =>
    <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
      'thumnail': instance.thumnail,
      'blogMobileLink': instance.blogMobileLink,
      'description': instance.description,
      'bloggername': instance.bloggername,
      'bloggerlink': instance.bloggerlink,
      'postdate': instance.postdate,
    };
