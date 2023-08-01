import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:my_madamn_app/Reservation/reservationscreen.dart';
import 'package:my_madamn_app/SalonsScreen/SalonListScreen.dart';
import 'package:my_madamn_app/auth_screen/Login/login_screen.dart';
import 'package:my_madamn_app/auth_screen/Login/sign_in_provider.dart';
import 'package:my_madamn_app/auth_screen/SignUp/chose_role.dart';
import 'package:my_madamn_app/auth_screen/SignUp/signup_screen.dart';
import 'package:my_madamn_app/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_screen/Login/internet_provider.dart';

void main() async  {
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
 /* void initState(){
    super.initState();
    //checkUser();
  }*/
  

  var isLoggedin = false;

  /*checkUser() async {
    auth.authStateChanges().listen((User? user) {
      if (user == null && mounted) {
        isLoggedin = false;
      }else{
        isLoggedin = true;
      }
      setState(() {
        
      });

     });
  }*/
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider(),
    //  child:
     /* return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: ((context)=>SignInProvider())
            ),
             ChangeNotifierProvider(
            create: ((context)=>InternetProvider())
            ),
            ],*/
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'madamen app',
          
          home:   LoginScreen(), 
          
        
          
        ),
      );
   // );
  }
}
