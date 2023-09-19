import 'package:app_rim/Consts/const.dart';
import 'package:app_rim/widgets_common/normal_text.dart';

Widget customTextField({label , hint, controller,isDesc = false}){
  return TextFormField(
    maxLines: isDesc ? 4 : 1,
    decoration: InputDecoration(
      isDense: true,
      label: normalText(text: label),
      border:OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: whiteColor,
        ),
      ) ,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: whiteColor,
        ),
      ),
      hintText: hint,
      hintStyle: const TextStyle(color: fontGrey,fontSize: 13),
    ), 
  );
}