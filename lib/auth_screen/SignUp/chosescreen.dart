import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_madamn_app/auth_screen/SignUp/SignUp.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../Consts/colors.dart';
import '../../widgets_common/normal_text.dart';
import '../../widgets_common/our_button.dart';

class ChoseScreen extends StatefulWidget {
  const ChoseScreen({super.key});

  @override
  State<ChoseScreen> createState() => _ChoseScreenState();
}

class _ChoseScreenState extends State<ChoseScreen> {
    final String userType='';

  TextEditingController villeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: 500,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bgimg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
              
                80.heightBox,
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.heightBox,
                      Center(
                        child: boldText(
                          text: "Sign Up",
                          color: BbRed,
                        ),
                      ),
                   
                      6.heightBox,
                  
                      SizedBox(height: 80),
                      Center(
                        child: boldText(
                          text: "Vous Etes ?",
                          color: BbRed,
                        ),
                      ),
                      SizedBox(height: 100),
                  
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 110,
                            width: 110,
                            child: ourButton(
                              color: BbRed.withOpacity(0.5),
                              title: "Centre de Beauté",
                              onPress: () async {
                                Get.to(() => Signup(userType: "salons"));
                                     print(userType);


                              },
                            ),
                          ),
                          SizedBox(
                            height: 110,
                            width: 110,
                            child: ourButton(
                              color: BbRed.withOpacity(0.5),
                              title: "Freelancer (Service à domicile)",
                              onPress: () async {
                              Get.to(() => Signup(userType: "freelancer"));
                             print(userType);


                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ).box
                      .width(300)
                      .height(500)
                      .color(Colors.white.withOpacity(0.5))
                      .rounded
                      .padding(const EdgeInsets.all(8))
                      .make(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
