import 'package:json_annotation/json_annotation.dart';

part 'vertext_search_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class VertextSearchDto {

  @JsonKey(fromJson: validateNonEmptyString, toJson: identityFunction)
  String? title;

  String? blogMobileLink;

  @JsonKey(fromJson: validateNonEmptyString, toJson: identityFunction)
  String? postdate;

  final List<String?> img = [];

  @JsonKey(fromJson: validateNonEmptyString, toJson: identityFunction)
  final String? location;

  @JsonKey(fromJson: validateNonEmptyString, toJson: identityFunction)
  final String? recommend;

  final List<String?> tag = [];

  @JsonKey(fromJson: validateNonEmptyString, toJson: identityFunction)
  String? desc;

  VertextSearchDto({
    required this.title,
    required this.blogMobileLink,
    required this.postdate,
    required this.location,
    required this.recommend,
    required this.desc,
  });

  // 공백 및 빈 문자열을 검증하는 함수
  static String? identityFunction(String? value) => value;

  // 공백 및 빈 문자열을 검증하는 함수
  static String? validateNonEmptyString(String? value) {

    if (value == null || value.trim().isEmpty || value.toLowerCase() == 'string') {
      return null;
    }

    return value;
  }

  Map<String, dynamic> toJson() => _$VertextSearchDtoToJson(this);

  factory VertextSearchDto.fromJson(Map<String, dynamic> json) =>
      _$VertextSearchDtoFromJson(json);
}
