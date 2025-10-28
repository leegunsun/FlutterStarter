// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'img_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ImgSearchModel _$ImgSearchModelFromJson(Map<String, dynamic> json) =>
    _ImgSearchModel(
      lastBuildDate: json['lastBuildDate'] as String,
      total: json['total'] as num,
      start: json['start'] as num,
      display: json['display'] as num,
      items: (json['items'] as List<dynamic>)
          .map((e) => SearchItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ImgSearchModelToJson(_ImgSearchModel instance) =>
    <String, dynamic>{
      'lastBuildDate': instance.lastBuildDate,
      'total': instance.total,
      'start': instance.start,
      'display': instance.display,
      'items': instance.items,
    };
