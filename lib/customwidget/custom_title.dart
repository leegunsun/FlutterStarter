import 'package:dateapp/theme/custom_theme_color.dart';
import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    super.key,
    required this.title,
    this.underlineColor = CustomThemeColor.underlineTop,
    this.fontColor = Colors.white,
    BoxShadow? boxShadow,
  }) : boxShadow = boxShadow ??
       CustomThemeColor.underlineShadow;

  final String title;
  final Color underlineColor;
  final Color fontColor;
  final BoxShadow boxShadow;

  factory CustomTitle.bottom({
    required String title,
  }) {
    return CustomTitle(title: title,
        underlineColor: CustomThemeColor.underlineBottom,
        fontColor: Colors.black,
        boxShadow: BoxShadow(
          color: Colors.transparent,
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20,),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                color: underlineColor,
                boxShadow: [
                  boxShadow
                ]
            ),
            child: Align(
              heightFactor: 0.3,
              widthFactor: 1,
              alignment: Alignment.bottomCenter,
              child: Text(" $title ", style: TextStyle(
                  color: fontColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),),
            ),
          ),
        ),
      ],
    );
  }
}
