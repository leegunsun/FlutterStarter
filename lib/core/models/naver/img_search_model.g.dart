// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'img_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImgSearchModel _$ImgSearchModelFromJson(Map<String, dynamic> json) =>
    ImgSearchModel(
      lastBuildDate: json['lastBuildDate'] as String,
      total: json['total'] as num,
      start: json['start'] as num,
      display: json['display'] as num,
      items: (json['items'] as List<dynamic>)
          .map((e) => SearchItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ImgSearchModelToJson(ImgSearchModel instance) =>
    <String, dynamic>{
      'lastBuildDate': instance.lastBuildDate,
      'total': instance.total,
      'start': instance.start,
      'display': instance.display,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

SearchItemDto _$SearchItemDtoFromJson(Map<String, dynamic> json) =>
    SearchItemDto(
      title: json['title'] as String,
      link: json['link'] as String,
      thumbnail: json['thumbnail'] as String,
      sizeheight: json['sizeheight'] as String,
      sizewidth: json['sizewidth'] as String,
    );

Map<String, dynamic> _$SearchItemDtoToJson(SearchItemDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
      'thumbnail': instance.thumbnail,
      'sizeheight': instance.sizeheight,
      'sizewidth': instance.sizewidth,
    };
