import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomThemeColor {
  static const List<BoxShadow> cardBoxShadow = [
    BoxShadow(
      color: Color(0x55004B82), // 보라색 계열의 어두운 색을 섞은 그림자
      blurRadius: 10,
      spreadRadius: -5,
      offset: Offset(0, 7), // 더 아래쪽으로 퍼지는 효과
    ),
    BoxShadow(
      color: Color(0x66000000), // 반투명 검은색 (배경과 조화롭게)
      blurRadius: 3, // 부드러운 확산 효과
      spreadRadius: -3, // 그림자 퍼짐 정도
      offset: Offset(0, 6), // 아래쪽으로 이동하여 입체감 강화
    ),
  ];

  static const BoxShadow underlineShadow = BoxShadow(
    color: Colors.black54,
    offset: Offset(0, 2),
    blurRadius: 2,
  );

  static const Color cardBackground = Colors.white;
  static Color? cardRecommendBackground = Colors.grey[200];
  static Color? cardSecondFont = Colors.grey[600];
  static Color? cardThirdFont = Colors.grey[500];
  static const Color point = Colors.tealAccent;
  static const Color icon = Colors.black54;

  static Color? starFill = Colors.yellow[200];

  static const Color underlineTop = Color(0xFF512DA8);
  static const Color underlineBottom = Color(0xFFB39DDB);

}
