import 'package:my_madamn_app/Consts/const.dart';
import 'package:my_madamn_app/widgets_common/normal_text.dart';
Widget ourButton({title,color=purpleColor ,color1=whiteColor, onPress}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      primary: color,
      padding: const EdgeInsets.all(12),
      //maximumSize:Size.fromWidth(30),
    ),
    onPressed: onPress,
     child: normalText(
      color: color1,
      text:title,
      size: 16.0,
      ),
     );
}