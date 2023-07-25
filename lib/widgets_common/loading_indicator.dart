import 'package:my_madamn_app/Consts/const.dart';

Widget loadingIndicator({circleColor = purpleColor }){

  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(circleColor),
    ),

  );
}