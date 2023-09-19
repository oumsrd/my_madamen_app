import 'package:app_rim/Consts/const.dart';
import 'package:velocity_x/velocity_x.dart';
Widget normalText({text,color=Colors.white,double size=15.0}){
  return "$text".text.color(color).size(size).make();
}
Widget boldText({text,color=Colors.white,double size=30.0}){ 
  return "$text".text.semiBold.color(color).size(size).make();
}