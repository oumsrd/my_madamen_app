import 'package:app_rim/Consts/const.dart';

Widget loadingIndicator({circleColor = purpleColor }){

  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(circleColor),
    ),

  );
}