import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_madamn_app/ReservationHistorique/reservationhistorique.dart';
import 'package:my_madamn_app/auth_screen/Login/login_screen.dart';
import 'package:my_madamn_app/widgets_common/our_button.dart';

import '../../provider/app_provider.dart';
import 'package:provider/provider.dart';

import '../Profil/EditProfil.dart';
import '../change_password/change_password.dart';
import '../constants/routes.dart';
import '../favourite_screen/favourite_screen.dart';
import '../firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import '../widgets_common/AppBar_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
 
    Map<String, dynamic> salonData = {};
    String email="";
    String name="";
    String address="";
    String phone="";
    String cartNumber="";
    String image="";
     // Initialisation des données du salon
Future<void > fetchUserData() async {
 try{ String userId = FirebaseAuth.instance.currentUser!.uid;
print(userId);
  DocumentSnapshot<Map<String, dynamic>> salonSnapshot =
      await FirebaseFirestore.instance.collection("users").doc(userId).get();
      if(salonSnapshot.exists){setState(() {  
        email=salonSnapshot['email'];
        name=salonSnapshot['name'];
      //  address=salonSnapshot['address'];
       // phone=salonSnapshot['phone'];
        //cartNumber=salonSnapshot['cartNumber'];
        image=salonSnapshot['image'];
         salonData = salonSnapshot.data()!;
});}

    print(salonData);}
catch (e){print(e);}

}
@override
  void initState() {
    fetchUserData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    print("proooovider");  
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
            image == ""
                    ? const Icon(
                       Icons.person_outline,
                        size: 100,
                      )
                    : 
                    CircleAvatar(
                        backgroundImage:
                          NetworkImage(image),
                        radius: 60,
                      ),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  email,
                ),
                const SizedBox(
                  height: 4.0,
                ),
                SizedBox(
                  height: 40,
                  width: 150,
                  child: ourButton(
                    title: "Modifier Profile",
                    onPress: () {
                      Routes.instance
                          .push(widget: const EditProfile(), context: context);
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: HistoriqueReservation(), context: context);
                  },
                  leading: const Icon(Icons.shopping_bag_outlined),
                  title: const Text("Mes réservations"),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance.push(
                        widget: const FavouriteScreen(), context: context);
                  },
                  leading: const Icon(Icons.favorite_outline),
                  title: const Text("Favouris"),
                ),
              /*  ListTile(
                  onTap: () {
                   /* Routes.instance
                        .push(widget: const AboutUs(), context: context);*/
                  },
                  leading: const Icon(Icons.info_outline),
                  title: const Text("About us"),
                ),*/
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: const ChangePassword(), context: context);
                  },
                  leading: const Icon(Icons.change_circle_outlined),
                  title: const Text("Changer Mot de passe"),
                ),
                ListTile(
                  onTap: ()async {
                     FirebaseAuthHelper.instance.signOut();
                      Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen(userType: "",)), // Replace with your login screen widget
                 ); 


                    //setState(() {});
                  },
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text("Se déconnecter "),
                ),
                const SizedBox(
                  height: 12.0,
                ),
               // const Text("Version 1.0.0")
              ],
            ),
          ),
        ],
      ),
    );
  }
}