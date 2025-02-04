// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vertext_search_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VertextSearchDto _$VertextSearchDtoFromJson(Map<String, dynamic> json) =>
    VertextSearchDto(
      title: VertextSearchDto.validateNonEmptyString(json['title'] as String?),
      blogMobileLink: json['blogMobileLink'] as String?,
      postdate:
          VertextSearchDto.validateNonEmptyString(json['postdate'] as String?),
      location:
          VertextSearchDto.validateNonEmptyString(json['location'] as String?),
      recommend:
          VertextSearchDto.validateNonEmptyString(json['recommend'] as String?),
      desc: VertextSearchDto.validateNonEmptyString(json['desc'] as String?),
      category: $enumDecode(_$BlogCategoryEnumMap, json['category']),
      tag: json['tag'] == null
          ? const []
          : VertextSearchDto._crawlTagFromJson(json['tag'] as String?),
      crawlContent: json['crawlContent'] == null
          ? const []
          : VertextSearchDto._crawlContentFromJson(
              json['crawlContent'] as List<Map<String, dynamic>?>),
    );

Map<String, dynamic> _$VertextSearchDtoToJson(VertextSearchDto instance) =>
    <String, dynamic>{
      'title': VertextSearchDto.identityFunction(instance.title),
      'blogMobileLink': instance.blogMobileLink,
      'postdate': VertextSearchDto.identityFunction(instance.postdate),
      'crawlContent':
          VertextSearchDto._crawlContentToJson(instance.crawlContent),
      'location': VertextSearchDto.identityFunction(instance.location),
      'recommend': VertextSearchDto.identityFunction(instance.recommend),
      'tag': VertextSearchDto._crawlTagToJson(instance.tag),
      'desc': VertextSearchDto.identityFunction(instance.desc),
      'category': _$BlogCategoryEnumMap[instance.category]!,
    };

const _$BlogCategoryEnumMap = {
  BlogCategory.FOOD: 'FOOD',
  BlogCategory.CAFE: 'CAFE',
  BlogCategory.DATE: 'DATE',
  BlogCategory.TRAVEL: 'TRAVEL',
  BlogCategory.ACTIVITY: 'ACTIVITY',
  BlogCategory.CULTURE: 'CULTURE',
  BlogCategory.NIGHTLIFE: 'NIGHTLIFE',
  BlogCategory.OUTDOOR: 'OUTDOOR',
  BlogCategory.SHOPPING: 'SHOPPING',
  BlogCategory.STAY: 'STAY',
  BlogCategory.EVENT: 'EVENT',
  BlogCategory.PET_FRIENDLY: 'PET_FRIENDLY',
  BlogCategory.LUXURY: 'LUXURY',
  BlogCategory.BUDGET: 'BUDGET',
};
