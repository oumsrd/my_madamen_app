import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:my_madamn_app/SalonsScreen/SalonListScreen.dart';
import 'package:my_madamn_app/auth_screen/Login/login_screen.dart';
import 'package:my_madamn_app/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Salon/ReservationListe.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51MWx8OAVMyklfe3CsjEzA1CiiY0XBTlHYbZ8jQlGtVFIwQi4aNeGv8J1HUw4rgSavMTLzTwgn0XRlwoTVRFXyu2h00mRUeWmAf";
  await Firebase.initializeApp();

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String userType='';
  var auth = FirebaseAuth.instance;
  var isLoggedin = false;

  @override
  void initState() {
    checkUser();
    super.initState();
    
  }

  checkUser() async {
    auth.authStateChanges().listen((User? user) async {
      if (user != null && mounted) {
            await determineUserType(user);
             setState(() {
          isLoggedin = true;
         
        });
       
      }
    });
  }

  Future<void> determineUserType(User user) async {
    CollectionReference clientsCollection =
        FirebaseFirestore.instance.collection('users');
    CollectionReference salonsCollection =
        FirebaseFirestore.instance.collection('salons');
    CollectionReference freelancersCollection =
        FirebaseFirestore.instance.collection('freelancers');
    bool isClient =
        await clientsCollection.doc(user.uid).get().then((snapshot) => snapshot.exists);
    bool isSalon =
        await salonsCollection.doc(user.uid).get().then((snapshot) => snapshot.exists);      
          print("3333333333333333333333333333333333");
    bool isFreelancer = await freelancersCollection.doc(user.uid).get().then((snapshot) => snapshot.exists);
            print("444444444444444444444444444444");


    if (isClient) {
      userType = "client";
    //return UserType.client;
  } else if (isSalon) {
         print("55ggggggggg");
    userType = "salons";
    //return UserType.salons;
  } else if (isFreelancer) {
    print("66666666666666666666666666");
    userType = "freelancer";
    //return UserType.freelancer;
  } else {
        print("66666666666666666666666666");
   // return UserType.client; // Type par défaut
  }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'madamen app',

      home: 
  // MyAppPreferences.loggedInUserType == UserType.client
  (userType=="client" && isLoggedin)
      ? SalonListScreen(userType: "client",)
     :( userType=="salons" && isLoggedin) ? 
     ReservationList(userType: "salons"): 
     (userType=="freelancer" && isLoggedin) ? 
     ReservationList(userType: "freelancer")
     : LoginScreen(userType: "",)
      ),
      // );
    );
  }
}
