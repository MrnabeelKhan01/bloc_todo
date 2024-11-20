import 'package:flutter/material.dart';


class FrontendConfigs {
  static Color kAppPrimaryColor = const Color(0xff7043C8);
  static Color kAppSecondaryColor = const Color(0xffF4F7FA);
  static Color kAppYellowColor = const Color(0xffF2BB71);
  static Color kAppGreyColor = const Color(0xff6B7280);
  static BorderSide kAppBorderSide =
      const BorderSide(color: Color(0xffE2E4EA), width: 1);
  static BorderRadius kAppBorderRadius = BorderRadius.circular(30);
  static TextStyle kAppHeading = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Color(0xff111827),
      fontFamily: "EncodeSansSemiCondensed");
  static TextStyle kAppSubHeading = const TextStyle(
      fontFamily: "EncodeSansSemiCondensed",
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color(0xff111827));
  static BoxDecoration kAppDecoration = BoxDecoration(
      boxShadow: [
        BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.16))
      ],
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xffE2E4EA), width: 1));
  static String kAppLogo = "assets/images/app_logo.png";

}
