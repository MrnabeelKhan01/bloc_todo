import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  CustomText(
      {Key? key,
      required this.text,
      this.color,
      this.textAlign,
      this.fontSize = 14,
      this.fontWeight = FontWeight.w400,
      this.letterSpacing})
      : super(key: key);
  String text;
  FontWeight fontWeight;
  double fontSize;
  Color? color;
  double? letterSpacing;
  TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      text,
      style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          fontFamily: "EncodeSansSemiCondensed",
          height: 1.5,
          color: color ?? const Color(0xff111827),
          letterSpacing: letterSpacing),
    );
  }
}
