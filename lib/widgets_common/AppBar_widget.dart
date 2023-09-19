import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_rim/widgets_common/menu_boutton.dart';
import '../Consts/colors.dart';

Widget CustomAppBar() {
  return AppBar(
    backgroundColor: BbPink,
    leading: Builder(
      builder: (context) => IconButton(
        onPressed: () {
                  Get.to(() =>  MenuBoutton(context));

        },
        icon: Icon(Icons.menu),
      ),
    ),
    title: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Image.asset(
              'assets/madamen.png',
              height: 200,
              
              width: 200,
            ),
          ),
        ),
      ],
    ),
    actions: [
    /*  IconButton(
        onPressed: () {
        Get.to(() =>  RechercheScreen());
        },
        icon: Icon(Icons.search),
      ),*/
    ],
  );
}
