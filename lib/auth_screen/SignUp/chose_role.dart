import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_madamn_app/auth_screen/SignUp/chosescreen.dart';
import 'package:my_madamn_app/auth_screen/SignUp/signup_screen.dart';
//import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';
import '../../Consts/colors.dart';
import '../../widgets_common/normal_text.dart';
import '../../widgets_common/our_button.dart';
class ChoseRole extends StatefulWidget {
  const ChoseRole({super.key});

  @override
  State<ChoseRole> createState() => _ChoseRoleState();
}

class _ChoseRoleState extends State<ChoseRole> {
//  Service loginController =Get.put(Service());
//'eve.holt@reqres.in'
//'pistol'
   

  TextEditingController villeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity ,
          width: 500,
          //backgroundColor : const Color.fromARGB(0, 97, 21, 250),
       
          decoration:const BoxDecoration(
           image: DecorationImage(
            image: AssetImage("assets/bgimg.jpg"),
            fit: BoxFit.cover,
          ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                children: [
                 Container(
                   width: 500,
                   child: Image.asset("assets/madamen.png", fit: BoxFit.contain,height: 200,).box
                    .width(200)
                    .height(250)
                   .make(),
                 ),
             
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children : [
                        20.heightBox,
                                          Center(child: boldText(text: "Sign Up",color: BbRed)),

                        Row(children:[ 
                          20.widthBox,
                          normalText(text:"Ville",color: BbRed)]),
                        6.heightBox,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: TextFormField(
                            controller: villeController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Localisation automatique',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color:  BbRed),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color:  BbRed), // Couleur du contour lorsqu'en focus
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                            ),
                          ),
                        ),
                        SizedBox(height: 80),
                        Center(child: boldText(text: "Vous Etes ?",color: BbPink)),
                        SizedBox(height: 40,),
                      Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    SizedBox(
      height: 110,
      width: 110,
      child: ourButton(
        color: BbRed.withOpacity(0.5),
        title: "Fournisseur de services",
        onPress: () async {
          // Service.login(loginController.emailController,loginController.passwordController);
          Get.to(() => const ChoseScreen());
        },
      ),
    ),
    SizedBox(
      height: 110,
      width: 110,
      child: ourButton(
        color: BbRed.withOpacity(0.5),
        title: "Cliente",
        onPress: () async {
           Get.to(() =>  SignupScreen());
        },
      ),
    ),
  ],
),

                      ]
                    ).box
                    .width(300)
                    .height(500)
                    .color(Colors.white.withOpacity(0.5))
                    .rounded
                    .padding(const EdgeInsets.all(8))
                    .make(),
                  ),
                
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}