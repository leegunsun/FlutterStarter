// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NaverApiBlogSearchModel _$NaverApiBlogSearchModelFromJson(
  Map<String, dynamic> json,
) => _NaverApiBlogSearchModel(
  lastBuildDate: json['lastBuildDate'] as String,
  total: json['total'] as num,
  start: json['start'] as num,
  display: json['display'] as num,
  items: (json['items'] as List<dynamic>)
      .map((e) => BlogSearchItems.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$NaverApiBlogSearchModelToJson(
  _NaverApiBlogSearchModel instance,
) => <String, dynamic>{
  'lastBuildDate': instance.lastBuildDate,
  'total': instance.total,
  'start': instance.start,
  'display': instance.display,
  'items': instance.items,
};
