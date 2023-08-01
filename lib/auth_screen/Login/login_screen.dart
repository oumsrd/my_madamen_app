import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:my_madamn_app/SalonsScreen/SalonListScreen.dart';
import 'package:my_madamn_app/auth_screen/Login/sign_in_provider.dart';
import 'package:my_madamn_app/auth_screen/SignUp/chose_role.dart';
import 'package:my_madamn_app/auth_screen/SignUp/signup_screen.dart';
import 'package:my_madamn_app/bienvenue/bienvenue.dart';
import 'package:my_madamn_app/widgets_common/utils/snack_bar.dart';
import 'package:my_madamn_app/widgets_common/next_screen.dart';
import 'package:provider/provider.dart';
//import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';
import '../../Consts/colors.dart';
import '../../Consts/string.dart';
import '../../constants/constants.dart';
import '../../constants/routes.dart';
import '../../firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
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
  bool isShowPassword = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
 bool isEmailValid = true;
 bool isPasswordValid = true;
   bool rememberMeChecked = false;
   Future<void> _login() async {
    try {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // L'utilisateur est maintenant connecté, vous pouvez gérer la navigation vers d'autres pages ici.
    } catch (e) {
      // Gérez les erreurs d'authentification ici (par exemple, afficher une boîte de dialogue d'erreur).
      print('Erreur de connexion : $e');
    }
  }


  
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
                                 50.heightBox,

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
                            100.widthBox,
                           // normalText(text: "email", color: BbRed),
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
                              errorText: isEmailValid ? null : 'E-mail invalide',
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            20.widthBox,
                           // normalText(text: "password", color: BbRed),
                          ],
                        ),
                        6.heightBox,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: TextFormField(
                            controller:passwordController,
                           obscureText: isShowPassword,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Mot de passe',
                               prefixIcon: const Icon(
                               Icons.password_sharp,
                                  ),
                                   suffixIcon: CupertinoButton(
                      onPressed: () {
                        setState(() {
                          isShowPassword = !isShowPassword;
                        });
                      },
                      padding: EdgeInsets.zero,
                      child: const Icon(
                        Icons.visibility,
                        color: Colors.grey,
                      )),
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
                                onPressed: (){
                                  handleGoogleSignIn();
                                 },
                                controller: googleController,
                                successColor: Colors.red,
                                width: MediaQuery.of(context).size.width*0.80,
                                elevation: 0,
                                borderRadius: 25,
                                color: Colors.red,
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
                              ),
                              const SizedBox(height: 10,),
                              ///facebook login button 
                                RoundedLoadingButton(
                                controller: googleController,
                                successColor: Colors.red,
                                width: MediaQuery.of(context).size.width*0.80,
                                 elevation: 0,
                                borderRadius: 25,
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
                          100.heightBox,
                          Center(
                            child: SizedBox(
                              height: 45,
                              width: context.screenWidth - 107,
                              child: ourButton(
                                color: BbRed,
                                title:"Se connecter",
                                onPress: () async {
                  bool isVaildated = loginVaildation(emailController.text, passwordController.text);
                  if (isVaildated) {
                    bool isLogined = await FirebaseAuthHelper.instance
                        .login(emailController.text, passwordController.text, context);
                    if (isLogined) {
                        Get.to(() =>  BienvenueScreen());

                    }
                  }
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
                   sp.getUserDataFromFirestore(sp.uid).then((value) => sp.saveDataToSharedPreferences().then((value) => sp.setSignIn().then((value) {
                    googleController.success();
                    handleAfterSignIn();
                   })));
                                }
                else{  
                       // user does not exist
                       sp.saveDataToFirestore().then((value) => sp.saveDataToSharedPreferences()
                       .then((value) => sp.setSignIn().then((value){
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