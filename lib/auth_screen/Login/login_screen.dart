import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_madamn_app/Salon/ReservationListe.dart';
import 'package:my_madamn_app/auth_screen/SignUp/chose_role.dart';
import 'package:my_madamn_app/bienvenue/bienvenue.dart';
import 'package:my_madamn_app/widgets_common/square_tile.dart';

//import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';
import '../../Consts/colors.dart';
import '../../Consts/string.dart';
import '../../constants/constants.dart';
import '../../firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import '../../widgets_common/normal_text.dart';
import '../../widgets_common/our_button.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'ForgetPassword.dart';

class LoginScreen extends StatefulWidget {
  final String userType;
  const LoginScreen({super.key, required this.userType});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
} 
class _LoginScreenState extends State<LoginScreen> {
 
  String userEmail='';

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
    } catch (e) {
      print('Erreur de connexion : $e');
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
              
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
              children: [
                80.heightBox,

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
                             boldText(text: rememberMe, color: BbRed,size: 10.0,),
                             15.widthBox,
                             Align(
                               alignment: Alignment.centerRight,
                               child: GestureDetector(
                                 onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context){return ForgetPasswordPage();
                                  }));
                                 },
                                 child: boldText(text: forgetPassword , color:BbRed, size: 10.0),
                               ),
                             ),
                  
                           ],
                         ),
                         20.heightBox,
                         Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SquareTile(
                              onTap:() async {
                                await signInWithGoogleAndSaveData() ;
                                //signInWithGoogle();
                                 Navigator.pushReplacement(
                                       context,
                              MaterialPageRoute(builder: (context) => BienvenueScreen(userType: widget.userType,)),
                                   );} ,
                              imagePath: "assets/google.png"),
                              SizedBox(width: 25,),
                               SquareTile(
                               onTap:() async {
                                await  signInWithFacebookAndSaveData();
                                //signInWithFacebook();
                                 Navigator.pushReplacement(
                                       context,
                              MaterialPageRoute(builder: (context) => BienvenueScreen(userType: widget.userType,)),
                                   );} ,
                              imagePath: "assets/facebook.png"),
                          ],
                         ),
                       
                        100.heightBox,
                        Center(
                          child: SizedBox(
                            height: 45,
                            width: context.screenWidth - 107,
                            child: ourButton(
  color: BbRed,
  title: "Se connecter",
 onPress: () async {
  bool isVaildated = loginVaildation(emailController.text, passwordController.text);
  if (isVaildated) {
    bool isLogined = await FirebaseAuthHelper.instance.login(emailController.text, passwordController.text, context);
    if (isLogined) {
      // Vérification de l'appartenance de l'utilisateur à la collection "users"
      DocumentSnapshot<Map<String, dynamic>> userSnapshot = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid).get();
      if (userSnapshot.exists) {
      // L'utilisateur appartient à la collection "users"
      Get.to(() => BienvenueScreen(userType: "client",));
      } else {
      // Vérification de l'appartenance de l'utilisateur à la collection "freelancers"
      DocumentSnapshot<Map<String, dynamic>> freelancerSnapshot = await FirebaseFirestore.instance.collection("freelancers").doc(FirebaseAuth.instance.currentUser?.uid).get();
      if (freelancerSnapshot.exists) {
        // L'utilisateur appartient à la collection "freelancers"
        Get.to(() => ReservationList(userType: "freelancer"));
      } else {
        // L'utilisateur appartient à la collection "salons"
        DocumentSnapshot<Map<String, dynamic>> salonSnapshot = await FirebaseFirestore.instance.collection("salons").doc(FirebaseAuth.instance.currentUser?.uid).get();
        if (salonSnapshot.exists) {
        Get.to(() => ReservationList(userType: "salons"));
        }
      }
      }
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
    );

  }
  
}
Future<UserCredential> signInWithFacebook() async {
  final LoginResult loginResult =await FacebookAuth.instance.login();
  final OAuthCredential facebookAuthCredential =FacebookAuthProvider.credential(loginResult.accessToken!.token);
  final userData=await FacebookAuth.instance.getUserData();
  var userEmail=userData["email"];
  return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
}
signInWithGoogle() async {
// begin interactive sign in process
  final GoogleSignInAccount? gUser=await GoogleSignIn().signIn();
//obtain auth details from request 
  final GoogleSignInAuthentication gAuth =await gUser!.authentication;
  //create a new credential for the user
  final credential =GoogleAuthProvider.credential(
  accessToken: gAuth.accessToken,
  idToken: gAuth.idToken,
  );
return await FirebaseAuth.instance.signInWithCredential(credential);
}

Future<void> saveUserDataToDatabase(User user) async {
  String uid = user.uid;
  String email = user.email ?? "";
  String displayName = user.displayName ?? "";
  String photoUrl = user.photoURL ?? "";
  DateTime createdAt = DateTime.now();

  try {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'id':uid,
      'email': email,
      'name': displayName,
      'image': photoUrl,
     
    });
    print('Données utilisateur enregistrées dans la base de données.');
  } catch (e) {
    print('Erreur lors de l\'enregistrement des données utilisateur : $e');
  }
}

Future<void> signInWithGoogleAndSaveData() async {
  UserCredential userCredential = await signInWithGoogle();

  await saveUserDataToDatabase(userCredential.user!);

}
Future<void> signInWithFacebookAndSaveData() async {
  UserCredential userCredential = await signInWithFacebook();

  await saveUserDataToDatabase(userCredential.user!);

}
