import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  VoidCallback onPressed;
  String btnLabel;
  double width;
  double height;
  Color ?color;
  Color ?textColor;
  double ?textSize;
  FontWeight ?fontWeight;
  double ?elevation;

  AppButton(
      {super.key, required this.onPressed,
        required this.btnLabel,
        this.color,
        this.elevation=2,
        this.textSize=16,
        this.fontWeight=FontWeight.w600,
        this.textColor=Colors.white,
        this.width = double.infinity,
        this.height = 48});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation:elevation, backgroundColor: color ?? const Color(0xff7043C8),
          fixedSize: Size(width, height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side:const BorderSide(color:Color(0xff7043C8),width:1.5)
          )),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            btnLabel,
            style:  TextStyle(
              color:textColor!,
              fontWeight:fontWeight,
              fontFamily:"EncodeSansSemiCondensed",
              fontSize: textSize!,
            ),
          ),
        ],
      ),
    );
  }
}
