import 'package:app_rim/Consts/constant.dart';
import 'package:flutter/material.dart';



class EmptySection extends StatelessWidget {
  final String emptyImg, emptyMsg;
  const EmptySection({
    super.key,
    required this.emptyImg,
    required this.emptyMsg,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(emptyImg),
            height: 150.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: kLessPadding),
            child: Text(
              emptyMsg,
              style: kDarkTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
