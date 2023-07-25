
import 'package:my_madamn_app/Consts/constant.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget homeButtons({
  double? width,
  double? height,
  String? icon,
  String? title,
  VoidCallback? onPress,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(icon!, width: 26),
      10.heightBox,
      title!.text.fontFamily("sans_bold").color(kLightColor).make()
    ],
  ).box.rounded.white.size(width!, height!).shadowSm.make().onTap(() {
    if (onPress != null) {
      onPress();
    }
  });
}
