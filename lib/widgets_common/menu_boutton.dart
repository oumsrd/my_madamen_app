 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_madamn_app/Consts/const.dart';
import 'package:my_madamn_app/servicedomicile/ServiceDomicile.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Pack Bridal/SalonsList.dart';
import '../Profil/Profil.dart';
import '../ReservationHistorique/reservationhistorique.dart';
import 'normal_text.dart';
Widget MenuBoutton(BuildContext context) {
  return Drawer(
    child: Container(
      color: BbPink,
      child: ListView(
        padding: EdgeInsets.all(8),
        children: [
          40.heightBox,
          ListTile(
            title: normalText(text: 'Profil', color: BbRed, size: 20),
            onTap: () {
              // Rediriger vers l'écran du profil
               Navigator.push( context, MaterialPageRoute(builder: (context) => Profil(userName:"Es-sraidi",userFirstName: "Oumeyma",userProfilePicUrl: "assets/bgimg.jpg", reservations: [],)),);
            },
          ),
          ListTile(
            title: normalText(text: 'Service à domicile', color: BbRed, size: 20),
            onTap: () {
              // Rediriger vers l'écran du service à domicile
              Get.to(() => ServiceDomicile());
            },
          ),
          ListTile(
            title: normalText(text: 'Mes réservations', color: BbRed, size: 20),
            onTap: () {
               Get.to(() => HistoriqueReservation(reservations: [], userName: '',));

            },
          ),
          ListTile(
            title: normalText(text: 'Pack bridal', color: BbRed, size: 20),
            onTap: () {
              // Rediriger vers l'écran du pack bridal
               Navigator.push(context,MaterialPageRoute(builder: (context) => SalonsList()), );
            },
          ),
        ],
      ),
    ),
  );
}

