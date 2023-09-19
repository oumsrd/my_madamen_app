import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:app_rim/Consts/const.dart';
import 'package:app_rim/ReservationHistorique/reservationhistorique.dart';
import 'package:app_rim/SalonsScreen/SalonListScreen.dart';
import 'package:app_rim/auth_screen/Login/login_screen.dart';
import 'package:app_rim/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'Salon/ReservationListe.dart';
import 'NotificationApi.dart';
import 'package:timezone/data/latest.dart' as tzdata;

final navigatorKey=GlobalKey<NavigatorState>();


void main() async {
     WidgetsFlutterBinding.ensureInitialized();
  tzdata.initializeTimeZones();
  Stripe.publishableKey=stripePublishableKey;
  await Stripe.instance.applySettings();
 await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
final navigatorKey = GlobalKey<NavigatorState>();
void onClickedNotification(NotificationResponse? payload) {
  print("onClickedNotification called");
  if (navigatorKey.currentState != null) {
    navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => HistoriqueReservation()));
  }
}

    void listenNotifications()=>NotificationApi.onNotifications.stream.listen(onClickedNotification);

  String userType='';
  var auth = FirebaseAuth.instance;
  var isLoggedin = false;
  
  @override
  void initState() {
    checkUser();
    super.initState();
    NotificationApi.init(initScheduled: true);
    listenNotifications();
    
 /*   NotificationApi.showScheduledNotification(
      title: 'Dinner',
      body: 'Today at 6 pm',
      payload: 'dinner_6pm',
      scheduledDate: DateTime.now().add(Duration(seconds: 12))
    );*/
 
    
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
  } else if (isSalon) {
         print("55ggggggggg");
    userType = "salons";
  } else if (isFreelancer) {
    print("66666666666666666666666666");
    userType = "freelancer";
  } else {
        print("66666666666666666666666666");
  }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider(),
      child: GetMaterialApp(
       navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'app_rim',

      home: 
  (userType=="client" && isLoggedin)
      ? SalonListScreen(userType: "salons",)
     :( userType=="salons" && isLoggedin) ? 
     ReservationList(userType: "salons"): 
     (userType=="freelancer" && isLoggedin) ? 
     ReservationList(userType: "freelancer")
     : LoginScreen(userType: "salons",),
  
      ),
      // );
    );
  }
  
}
