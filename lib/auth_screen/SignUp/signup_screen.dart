import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:my_madamn_app/bienvenue/bienvenue.dart';
//import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';
import '../../Consts/colors.dart';
import '../../Consts/string.dart';
import '../../widgets_common/normal_text.dart';
import '../../widgets_common/our_button.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
//  Service loginController =Get.put(Service());
//'eve.holt@reqres.in'
//'pistol'
   

  TextEditingController emailController = TextEditingController();
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
                 Center(
                    child:  Container(
                   width: 400,
                   child: Image.asset("assets/madamen.png", fit: BoxFit.contain,height: 200,)
                 ),
                    
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
                          normalText(text:"Nom",color: BbRed)]),
                        6.heightBox,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              //hintText: 'Email',
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
                         Row(children:[ 
                          20.widthBox,
                          normalText(text:"Prénom",color: BbRed)]),
                        6.heightBox,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              //hintText: 'Email',
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

                        Row(children:[ 
                          20.widthBox,
                          normalText(text:"Email",color: BbRed)]),
                        6.heightBox,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              //hintText: 'Email',
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
                        SizedBox(height: 16),
                        Row(children:[ 
                          20.widthBox,
                          normalText(text:"Mot de passe ",color:BbRed)]),
                        6.heightBox,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: TextFormField(
                            controller:passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              //hintText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color:BbRed), // Couleur du contour
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: BbRed), // Couleur du contour lorsqu'en focus
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                            ),
                          ),
                        ),
                        Row(children:[ 
                          20.widthBox,
                          normalText(text:"Confirmez le mot de passe ",color:BbRed)]),
                        6.heightBox,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: TextFormField(
                            controller:passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              //hintText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color:BbRed), // Couleur du contour
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: BbRed), // Couleur du contour lorsqu'en focus
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                            ),
                          ),
                        ),
                        
                        SizedBox(height: 10),
                         Row(
                           children: [
                             2.widthBox,
                             Checkbox(
                              checkColor: BbRed,
                              //borderSide: const BorderSide(color:BbRed), 
                               value: false, // Ajoutez une valeur booléenne ici pour gérer l'état de la case à cocher
                               onChanged: (value) {
                                 // Ajoutez votre logique ici pour gérer le changement d'état de la case à cocher
                               },
                              activeColor: BbRed,

                             ),
                             normalText(text: "Se souvenir de moi ", color: BbRed,size: 10.0),
                           

                           ],
                         ),
                        30.heightBox,
                        
                        SizedBox(height: 15),
                        Center(
                          child: SizedBox(
                            height: 45,
                            width: context.screenWidth - 107,
                            child: ourButton(
                              color: BbRed,
                              title: "Créer un compte",
                              onPress: () async{
                                Get.to(() =>  BienvenueScreen());
                               
                              },
                            ),
                          ),
                        ),
                      ]
                    ).box
                    .width(300)
                    .height(630)
                    .color(Colors.white.withOpacity(0.5))
                   // .border(color: whiteColor)
                    .rounded
                    //.shadowMd
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