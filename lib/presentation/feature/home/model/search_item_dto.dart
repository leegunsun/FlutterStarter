
import 'package:freezed_annotation/freezed_annotation.dart';

/// title : "웹진 인벤 : 어른입맛 테스트 - 오픈이슈갤러리 어른입맛 테스트"
/// link : "https://upload3.inven.co.kr/upload/2024/01/22/bbs/i16545266120.jpg?MW=800"
/// thumbnail : "https://search.pstatic.net/sunny/?type=b150&src=https://upload3.inven.co.kr/upload/2024/01/22/bbs/i16545266120.jpg?MW=800"
/// sizeheight : "800"
/// sizewidth : "800"

part 'search_item_dto.freezed.dart';
part 'search_item_dto.g.dart';


@freezed
abstract class SearchItemDto with _$SearchItemDto {

  const factory SearchItemDto({
    required String title,
    required String link,
    required String thumbnail,
    required String sizeheight,
    required String sizewidth,
  }) = _SearchItemDto;

  factory SearchItemDto.fromJson(Map<String, dynamic> json) => _$SearchItemDtoFromJson(json);
}
