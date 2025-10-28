import 'package:dateapp/presentation/feature/home/model/search_item_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'img_search_model.freezed.dart';
part 'img_search_model.g.dart';

@freezed
abstract class ImgSearchModel with _$ImgSearchModel {

  const factory ImgSearchModel(
      {required String lastBuildDate,
      required num total,
      required num start,
      required num display,
      required List<SearchItemDto> items}) = _ImgSearchModel;

  factory ImgSearchModel.fromJson(Map<String, dynamic> json) => _$ImgSearchModelFromJson(json);
}
