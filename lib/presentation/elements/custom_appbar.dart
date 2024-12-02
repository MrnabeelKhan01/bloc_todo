import 'package:flutter/material.dart';

import 'custom_text.dart';

customAppBar(
  BuildContext context, {
  String title='',
  bool isShowMenu = false,
      required VoidCallback onTapMenu
}) {
  return AppBar(
    leading:
       IconButton(onPressed: () {  },
      icon: const Icon(Icons.arrow_back)),

    toolbarHeight:65,
    backgroundColor: Colors.white,
    elevation: 1,
    shadowColor:Colors.white,
    surfaceTintColor:Colors.white,
    centerTitle:true,
    title: CustomText(
      text: title,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),

  );
}
