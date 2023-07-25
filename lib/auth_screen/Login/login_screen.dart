import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:my_madamn_app/SalonsScreen/SalonListScreen.dart';
import 'package:my_madamn_app/auth_screen/Login/sign_in_provider.dart';
import 'package:my_madamn_app/auth_screen/SignUp/chose_role.dart';
import 'package:my_madamn_app/auth_screen/SignUp/signup_screen.dart';
import 'package:my_madamn_app/bienvenue/bienvenue.dart';
import 'package:my_madamn_app/utils/snack_bar.dart';
import 'package:my_madamn_app/widgets_common/next_screen.dart';
import 'package:provider/provider.dart';
//import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';
import '../../Consts/colors.dart';
import '../../Consts/string.dart';
import '../../widgets_common/normal_text.dart';
import '../../widgets_common/our_button.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'internet_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
bool checkEmailValid(String email) {
  // Regular expression to check the email format
  RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$',
  );
  return emailRegExp.hasMatch(email);
}




enum PasswordStrength {
  Weak, // Faible
  Medium, // Moyen
  Strong, // Fort
}

PasswordStrength checkPasswordStrength(String password) {
  // Vérification de la longueur du mot de passe
  if (password.length < 8) {
    return PasswordStrength.Weak;
  }

  // Vérification de la présence de caractères spéciaux
  RegExp specialCharsRegExp = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  if (!specialCharsRegExp.hasMatch(password)) {
    return PasswordStrength.Medium;
  }

  // Vérification de la présence de chiffres
  RegExp digitsRegExp = RegExp(r'\d');
  if (!digitsRegExp.hasMatch(password)) {
    return PasswordStrength.Medium;
  }

  // Vérification de la présence de lettres majuscules
  RegExp uppercaseRegExp = RegExp(r'[A-Z]');
  if (!uppercaseRegExp.hasMatch(password)) {
    return PasswordStrength.Medium;
  }

  return PasswordStrength.Strong;
}

class _LoginScreenState extends State<LoginScreen> {
//  Service loginController =Get.put(Service());
//'eve.holt@reqres.in'
//'pistol'
   final RoundedLoadingButtonController googleController= RoundedLoadingButtonController();
      final RoundedLoadingButtonController facebookController= RoundedLoadingButtonController();


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
 bool isEmailValid = true;
 bool isPasswordValid = true;
   bool rememberMeChecked = false;


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                children: [
                 Center(
                    child: Container(
                      width: 500,
                      child: Image.asset("assets/madamen.png", fit: BoxFit.contain,).box
                    .width(200)
                    .height(250)
                   .make(),
                    ),
                    
                  ),
             
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SingleChildScrollView(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.heightBox,
                        Center(child: boldText(text: "Login", color: BbRed)),
                        Row(
                          children: [
                            20.widthBox,
                            normalText(text: "email", color: BbRed),
                          ],
                        ),
                        6.heightBox,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              // hintText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: BbRed),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: BbRed),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                              errorText: isEmailValid ? null : 'E-mail invalide',
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            20.widthBox,
                            normalText(text: "password", color: BbRed),
                          ],
                        ),
                        6.heightBox,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              // hintText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: BbRed),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: BbRed),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                              errorText: isPasswordValid ? null : 'Mot de passe invalide',
                            ),
                          ),
                        ),
                          SizedBox(height: 10),
                           Row(
                             children: [
                               2.widthBox,
                                 Checkbox(
                                checkColor:whiteColor,
                          value: rememberMeChecked,
                         onChanged: (value) {
                        setState(() {
                        rememberMeChecked = value!;
                             });
                             },
                       activeColor: BbRed,
                      ),
                               normalText(text: rememberMe, color: BbRed,size: 10.0),
                               35.widthBox,
                               Align(
                                 alignment: Alignment.centerRight,
                                 child: GestureDetector(
                                   onTap: () {
                                     // Ajoutez votre logique ici pour gérer l'appui sur le texte "forget password"
                                   },
                                   child: normalText(text: forgetPassword , color:BbRed, size: 10.0),
                                 ),
                               ),
                    
                             ],
                           ),
                           Column(
                         crossAxisAlignment:CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundedLoadingButton(
                                controller: googleController,
                                successColor: Colors.red,
                                width: MediaQuery.of(context).size.width*0.80,
                                 onPressed: (){
                                  handleGoogleSignIn();
                                 },
                                  child: Wrap(
                                    children:const [
                                      Icon(
                                        FontAwesome.google,
                                        size: 20,
                                        color:Colors.white ,
                              ),
                              SizedBox(width: 15,),
                              Text("Sign in with Google",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)
                              ],
                              ),
                              color: Colors.red,
                              ),
                              const SizedBox(height: 10,),
                              ///facebook login button 
                                RoundedLoadingButton(
                                controller: googleController,
                                successColor: Colors.red,
                                width: MediaQuery.of(context).size.width*0.80,
                                 onPressed: (){},
                                  child: Wrap(
                                    children:const [
                                      Icon(
                                        FontAwesome.facebook,
                                        size: 20,
                                        color:Colors.white ,
                              ),
                              SizedBox(width: 15,),
                              Text("Sign in with Facebook",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)
                              ],
                              ),
                              color: Colors.blue,
                              )
                           ],),
                          30.heightBox,
                          Center(
                            child: SizedBox(
                              height: 45,
                              width: context.screenWidth - 107,
                              child: ourButton(
                                color: BbRed,
                                title:"Se connecter",
                              onPress: () async {
                               String email = emailController.text;
  String password = passwordController.text;

  // Vérification de l'e-mail
  if (!checkEmailValid(email)) {
  setState(() {
    isEmailValid = false;
  });
  return;
} else {
  setState(() {
    isEmailValid = true;
  });
}

                    
                      // Vérification du mot de passe
                      PasswordStrength passwordStrength = checkPasswordStrength(password);
                      if (passwordStrength == PasswordStrength.Weak) {
                        setState(() {
                          isPasswordValid = false;
                        });
                        return;
                      } else if (passwordStrength == PasswordStrength.Medium) {
                        // Le mot de passe est moyen
                        // Demander à l'utilisateur de renforcer son mot de passe ou continuer avec un mot de passe moyen (selon votre logique)
                      }
                    
                      // Les vérifications sont passées, procéder à la connexion ou à la création du compte
                      // Service.login(loginController.emailController, loginController.passwordController);
                      Get.to(() => BienvenueScreen());
                    },
                    
                    
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Center(
                            child: SizedBox(
                              height: 45,
                              width: context.screenWidth - 107,
                              child: ourButton(
                                color: BbRed,
                                title: "Créer un compte",
                                onPress: () async{
                                 Get.to(() =>  ChoseRole());
                                 
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
      ),
    );

  }
  //handling google sign in
  Future handleGoogleSignIn() async {
    final sp=context.read<SignInProvider>();
    final ip=context.read<InternetProvider>();
    await ip.checkInternetConnection();
    if(ip.hasInternet==false) {
         openSnackbar(context, "Check your Internet connection", Colors.red);
        googleController.reset();
        }
        else {
            await sp.signInWithGoogle().then((value){
              if(sp.hasError==true){
                openSnackbar(context, sp.errorCode.toString(), Colors.red);
                        googleController.reset();
              }
              else{
               //checking whether user exists or not
               sp.checkUserExists().then((value)async{
                if(value==true){
                   // user exists
                              
                                }
                else{  
                       // user does not exist
                       sp.saveDataToFirestore().then((value) => sp.saveDataToSharedPreferences().then((value) => sp.setSignIn().then((value){
                        googleController.success();
                        handleAfterSignIn();
                       })));




                          }
               });
              }
            });
                }
  }
   handleAfterSignIn(){
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      nextScreenReplace(context, BienvenueScreen());
    });
   }
}