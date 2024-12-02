import 'package:flutter/material.dart';

import '../../configs/frontend_configs.dart';
import 'custom_text.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    Key? key,
    this.controller,
    required this.hintText,
    this.isSecure = false,
    this.isPassword = false,
    this.onTap,
    required this.keyBoardType,
    required this.title,
  }) : super(key: key);
  final String hintText;
  final String title;
  bool isSecure;
  final TextInputType keyBoardType;

  bool isPassword;
  TextEditingController? controller;
  VoidCallback? onTap;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: widget.title,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 44,
          child: TextFormField(
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: "EncodeSansSemiCondensed",
              color: Color(0xff111827),
            ),
            keyboardType: widget.keyBoardType,
            controller: widget.controller,
            obscureText: widget.isSecure,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 18),
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                  color: Color(0xff9CA3AF),
                  fontFamily: "EncodeSansSemiCondensed",
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:const BorderSide(color:Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: FrontendConfigs.kAppBorderSide),
              fillColor: FrontendConfigs.kAppSecondaryColor,
              suffixIcon: widget.isPassword
                  ? InkWell(
                      borderRadius: FrontendConfigs.kAppBorderRadius,
                      onTap: () {
                        setState(() {
                          widget.isSecure = !widget.isSecure;
                        });
                        return widget.onTap!();
                      },
                      child: widget.isSecure
                          ? const Icon(Icons.visibility_off_outlined,
                              color: Colors.black, size: 20)
                          : const Icon(
                              Icons.remove_red_eye_outlined,
                              color: Colors.black,
                              size: 20,
                            ))
                  : null,
              filled: true,
            ),
          ),
        ),
      ],
    );
  }
}
