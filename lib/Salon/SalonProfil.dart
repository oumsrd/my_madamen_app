import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_madamn_app/Consts/colors.dart';
import 'package:my_madamn_app/Salon/PackBridalScreen.dart';
import 'package:my_madamn_app/widgets_common/our_button.dart';
import 'package:my_madamn_app/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:velocity_x/velocity_x.dart';

import '../auth_screen/Login/login_screen.dart';
import '../widgets_common/menu.dart';
import 'AddServices.dart';
import 'EditSalonProfil.dart';

class SalonProfilScreen extends StatefulWidget {
  final String userType;
  const SalonProfilScreen({Key? key, required this.userType}) : super(key: key);

  @override
  _SalonProfilScreenState createState() => _SalonProfilScreenState();
}

class _SalonProfilScreenState extends State<SalonProfilScreen> {
  
    Map<String, dynamic> salonData = {};
    String email="";
    String name="";
    String address="";
    String phone="";
    String cartNumber="";
    String image="";
     // Initialisation des données du salon
Future<void > fetchSalonData() async {
 try{ String userId = FirebaseAuth.instance.currentUser!.uid;
print(userId);
String collectionName="";
widget.userType=="freelancer"? collectionName="freelancers":widget.userType=="salons" ? collectionName="salons": collectionName="";
  DocumentSnapshot<Map<String, dynamic>> salonSnapshot =
      await FirebaseFirestore.instance.collection(collectionName).doc(userId).get();
      if(salonSnapshot.exists){setState(() {  
        email=salonSnapshot['email'];
        name=salonSnapshot['name'];
        address=salonSnapshot['address'];
        phone=salonSnapshot['phone'];
        cartNumber=salonSnapshot['cartNumber'];
        image=salonSnapshot['image'][0];
         salonData = salonSnapshot.data()!;
});}

    print(salonData);}
catch (e){print(e);}

}


  @override
  void initState() {
            fetchSalonData();
    super.initState();

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(  widget.userType=="salons"?  "Salon Profile": "Freelancer Profile"),
        backgroundColor: BbRed,
      ),
            drawer: Menu(context,widget.userType),

      body: Column(
        children: [
          Column(
            children: [
             
              CircleAvatar(
                      backgroundImage: NetworkImage(image),
                      radius: 60,
                    ),
              Text(
                //salonData['name'] ?? '',
                name,
                 // Assurez-vous d'adapter les champs aux clés de votre base de données
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
               // salonData['email'] ?? '',
               email
              ),
              Text(
              ///  salonData['address'] ?? '',
              address,
              ),
              Text(
               // salonData['cartNumber'] ?? '',
               cartNumber,
              ),
              Text(
               // salonData['phone'] ?? '',
               phone
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
                   //  Naviguez vers l'écran d'édition du profil du salon
                   Navigator.push(  context, MaterialPageRoute(builder: (context) => EditSalonProfile(userType: widget.userType,) ),  );
                  },
                ),
              ),
            ],
          ),
         
         
          20.heightBox,
           ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AddService(userType: widget.userType,)),
              );
            },
            leading: const Icon(Icons.local_florist),
            title: const Text("Services"),
          ),
          const SizedBox(
            height: 12.0,
          ), ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => PackBridalScreen(userType: widget.userType,)),
              );
            },
            leading: const Icon(Icons.local_mall),
            title: const Text("Pack Bridal"),
          ),
          const SizedBox(
            height: 12.0,
          ),
           ListTile(
            onTap: () {
              FirebaseAuthHelper.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen(userType: "",)),
              );
            },
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Déconnexion"),
          ),
          const SizedBox(
            height: 12.0,
          ),
           
          const SizedBox(
            height: 12.0,
          ),
         
          const SizedBox(
            height: 12.0,
          ),
        ],
      ),
    );
  }
}
