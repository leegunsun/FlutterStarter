import 'package:json_annotation/json_annotation.dart';

part 'img_search_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ImgSearchDto {
  final String lastBuildDate;
  final num total;
  final num start;
  final num display;
  final List<SearchItemDto> items;

  const ImgSearchDto(
      {required this.lastBuildDate,
      required this.total,
      required this.start,
      required this.display,
      required this.items});

  factory ImgSearchDto.fromJson(Map<String, dynamic> json) => _$ImgSearchDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ImgSearchDtoToJson(this);
}

/// title : "웹진 인벤 : 어른입맛 테스트 - 오픈이슈갤러리 어른입맛 테스트"
/// link : "https://upload3.inven.co.kr/upload/2024/01/22/bbs/i16545266120.jpg?MW=800"
/// thumbnail : "https://search.pstatic.net/sunny/?type=b150&src=https://upload3.inven.co.kr/upload/2024/01/22/bbs/i16545266120.jpg?MW=800"
/// sizeheight : "800"
/// sizewidth : "800"

@JsonSerializable()
class SearchItemDto {
  final String title;
  final String link;
  final String thumbnail;
  final String sizeheight;
  final String sizewidth;

  const SearchItemDto({
    required this.title,
    required this.link,
    required this.thumbnail,
    required this.sizeheight,
    required this.sizewidth,
  });

  factory SearchItemDto.fromJson(Map<String, dynamic> json) => _$SearchItemDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SearchItemDtoToJson(this);
}
