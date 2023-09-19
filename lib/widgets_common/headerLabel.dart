import 'package:app_rim/Consts/constant.dart';
import 'package:flutter/material.dart';


class HeaderLabel extends StatelessWidget {
  final String headerText;
  const HeaderLabel({
    super.key,
    required this.headerText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Text(
        headerText,
        style: TextStyle(color: kLightColor, fontSize: 24.0),
      ),
    );
  }
}
