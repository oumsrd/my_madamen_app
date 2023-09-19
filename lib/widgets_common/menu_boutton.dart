 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_rim/Consts/const.dart';
import 'package:app_rim/Pack%20Bridal/FreelancerPack.dart';
import 'package:app_rim/SalonsScreen/SalonListScreen.dart';
import 'package:app_rim/account_screen/account_screens.dart';
import 'package:app_rim/favourite_screen/favourite_screen.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Pack Bridal/SalonsList.dart';
import '../ReservationHistorique/reservationhistorique.dart';
import '../auth_screen/Login/login_screen.dart';
import '../constants/routes.dart';
import '../firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import '../provider/app_provider.dart';
import '../servicedomicile/FreelancersList.dart';
import 'normal_text.dart';
Widget MenuBoutton(BuildContext context) {
  AppProvider? appProvider = Provider.of<AppProvider>(
    context,
  );
  return Drawer(
    child: Container(
      color: BbPink,
      child: ListView(
        padding: EdgeInsets.all(8),
        children: [
          40.heightBox,
          ListTile(
            title: normalText(text: 'Accueil', color: whiteColor, size: 20),
            onTap: () {
               Get.to(() =>SalonListScreen(userType: "salons",));

            },
          ),
          ListTile(
            title: normalText(text: 'Profile', color: whiteColor, size: 20),
            onTap: () {
              // Rediriger vers l'écran du profil
              
              Get.to(() => AccountScreen());
          
},
          ),
          ListTile(
            title: normalText(text: 'Service à domicile', color: whiteColor, size: 20),
            onTap: () {
              // Rediriger vers l'écran du service à domicile
              Get.to(() => SalonListScreen(userType: "freelancer",));
            },
          ),
          ListTile(
            title: normalText(text: 'Mes réservations', color: whiteColor, size: 20),
            onTap: () {
               Get.to(() => HistoriqueReservation());

            },
          ),
            ListTile(
            title: normalText(text: 'Mes favoris', color: whiteColor, size: 20),
            onTap: () {
               Get.to(() => FavouriteScreen());

            },
          ),
          ListTile(
            title: normalText(text: 'Pack bridal', color: whiteColor, size: 20),
            onTap: () {
              // Rediriger vers l'écran du pack bridal
               Navigator.push(context,MaterialPageRoute(builder: (context) => SalonsList()), );
            },
          ),
           ListTile(
            title: normalText(text: 'Freelancer Pack bridal', color: whiteColor, size: 20),
            onTap: () {
              // Rediriger vers l'écran du pack bridal
               Navigator.push(context,MaterialPageRoute(builder: (context) => FreelancerPack()), );
            },
          ),
          ListTile(
            title: normalText(text: 'Se déconnecter', color: whiteColor, size: 20),
            onTap: () {
              FirebaseAuthHelper.instance.signOut();
                      Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen(userType:"salons",)), // Replace with your login screen widget
                 ); 


            },)
        ],
      ),
    ),
  );
}

