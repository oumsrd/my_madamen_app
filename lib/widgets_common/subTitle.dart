import 'package:my_madamn_app/Consts/constant.dart';
import 'package:flutter/material.dart';


class SubTitle extends StatelessWidget {
  final String subTitleText;
  const SubTitle({
    super.key,
    required this.subTitleText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kFixPadding),
      child: Text(
        subTitleText,
        textAlign: TextAlign.center,
        style: kSubTextStyle,
      ),
    );
  }
}
