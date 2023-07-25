import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget applogoWidget() {
  return Image.asset(
    'assets/Logo.png',
    color: Colors.white,
  )
      .box
      .color(
        Color.fromARGB(255, 100, 21, 255),
      )
      .size(200, 200)
      .padding(EdgeInsets.all(8))
      .rounded
      .make();
}
