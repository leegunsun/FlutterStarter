// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SearchItemDto _$SearchItemDtoFromJson(Map<String, dynamic> json) =>
    _SearchItemDto(
      title: json['title'] as String,
      link: json['link'] as String,
      thumbnail: json['thumbnail'] as String,
      sizeheight: json['sizeheight'] as String,
      sizewidth: json['sizewidth'] as String,
    );

Map<String, dynamic> _$SearchItemDtoToJson(_SearchItemDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
      'thumbnail': instance.thumbnail,
      'sizeheight': instance.sizeheight,
      'sizewidth': instance.sizewidth,
    };
