import 'package:flutter/material.dart';
import 'package:my_madamn_app/Salon/AddServices.dart';
import 'package:my_madamn_app/Salon/SalonProfil.dart';

import '../Consts/colors.dart';
import '../Salon/PackBridalScreen.dart';
import '../Salon/ReservationListe.dart';
import '../auth_screen/Login/login_screen.dart';
import '../firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';

Widget Menu(BuildContext context,String userType){
  //final String userType;
 
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
       const  DrawerHeader(
          decoration: BoxDecoration(
            color: BbRed,
          ),
          child:  Text(
              "Menu",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          title: Text("Pack Bridal"),
          onTap: () {
                           Navigator.push(context,MaterialPageRoute(builder: (context) => PackBridalScreen(userType: userType,)), );

          },
        ),
        ListTile(
          title: Text("Mes Reservations"),
          onTap: () {
               Navigator.push(context,MaterialPageRoute(builder: (context) => ReservationList(userType:userType ,)), );

            
          },
        ),
        ListTile(
          title: Text("Profile"),
          onTap: () {
             Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>SalonProfilScreen(userType: userType,)), // Replace with your login screen widget
                 ); 
          },
        ),
        
            ListTile(
            title: Text( 'Ajouter service' ),
            onTap: () {
              
                      Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AddService(userType: "")), // Replace with your login screen widget
                 ); 


            },),
             ListTile(
            title: Text( 'Se déconnecter' ),
            onTap: () {
              FirebaseAuthHelper.instance.signOut();
                      Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen(userType:"",)), // Replace with your login screen widget
                 ); 


            },),
      ],
    ),
  );
}