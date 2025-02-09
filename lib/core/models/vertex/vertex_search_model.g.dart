// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vertex_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VertexSearchModel _$VertexSearchModelFromJson(Map<String, dynamic> json) =>
    VertexSearchModel(
      title: VertexSearchModel.validateNonEmptyString(json['title'] as String?),
      blogMobileLink: json['blogMobileLink'] as String?,
      postdate:
          VertexSearchModel.validateNonEmptyString(json['postdate'] as String?),
      location:
          VertexSearchModel.validateNonEmptyString(json['location'] as String?),
      recommend: VertexSearchModel.validateNonEmptyString(
          json['recommend'] as String?),
      desc: VertexSearchModel.validateNonEmptyString(json['desc'] as String?),
      category: $enumDecode(_$BlogCategoryEnumMap, json['category']),
      tag: json['tag'] == null
          ? const []
          : VertexSearchModel._crawlTagFromJson(json['tag'] as String?),
      crawlContent: json['crawlContent'] == null
          ? const []
          : VertexSearchModel._crawlContentFromJson(
              json['crawlContent'] as List<Map<String, dynamic>?>),
    );

Map<String, dynamic> _$VertexSearchModelToJson(VertexSearchModel instance) =>
    <String, dynamic>{
      'title': VertexSearchModel.identityFunction(instance.title),
      'blogMobileLink': instance.blogMobileLink,
      'postdate': VertexSearchModel.identityFunction(instance.postdate),
      'crawlContent':
          VertexSearchModel._crawlContentToJson(instance.crawlContent),
      'location': VertexSearchModel.identityFunction(instance.location),
      'recommend': VertexSearchModel.identityFunction(instance.recommend),
      'tag': VertexSearchModel._crawlTagToJson(instance.tag),
      'desc': VertexSearchModel.identityFunction(instance.desc),
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
