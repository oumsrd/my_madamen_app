import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../Consts/colors.dart';
import '../../widgets_common/normal_text.dart';
import '../../widgets_common/our_button.dart';
class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
 
  String userEmail='';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose(){
emailController.dispose();
super.dispose();
  }

 Future passwordReset()async{
try{
  await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
  showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Text("Lien a été envoyé! , Vérifiez votre email "),
      );
  });
}on FirebaseAuthException catch(e){
  print(e);
  showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Text(e.message.toString()),
      );
  });

} 
}




@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity ,
        width: 500,       
        decoration:const BoxDecoration(
         image: DecorationImage(
          image: AssetImage("assets/bgimg.jpg"),
          fit: BoxFit.cover,
        ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  80.heightBox,
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SingleChildScrollView(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.heightBox,
                      Center(child: boldText(text: "Réinitialiser le mot de passe", color: BbRed,size: 22)),
                      100.heightBox,
                      Row(
                        children: [
                        normalText(text: "Entrer votre email pour vous envoyer ", color: Colors.black),
                        ],
                      ),
                       Row(
                        children: [
                        normalText(text: "le lien de réinitialisation : ", color: Colors.black),
                        ],
                      ),
                      50.heightBox,
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: 
                     TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Email',
                                prefixIcon: Icon(
                                Icons.email_outlined,
                                  ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: BbRed),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: BbRed),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                            ),
                          ),
                        ),
                      ),
           20.heightBox,
                       Center(
                          child: SizedBox(
                            height: 45,
                            width: context.screenWidth - 200,
                            child: ourButton(
                              color: BbRed,
                              title: "Réinitialiser",
                              onPress: () {
                               passwordReset();
                              },
                            ),
                          ),
                        ),
                      ]
                    ).box
                    .width(300)
                    .height(600)
                    .color(Colors.white.withOpacity(0.5))
                    .rounded
                    .padding(const EdgeInsets.all(8))
                    .make(),
                  ),
                ),
              
              ],
            )
          ),
        ),
      ),
    );

  }
 
}
