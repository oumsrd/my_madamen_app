import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_madamn_app/widgets_common/our_button.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';
import '../Consts/colors.dart';
import '../models/salon_model/salon_model.dart';
import '../models/user_model/user_model.dart';
import '../widgets_common/AppBar_widget.dart';
import '../widgets_common/menu.dart';

class EditSalonProfile extends StatefulWidget {
  final String userType;
  const EditSalonProfile({super.key, required this.userType});

  @override
  State<EditSalonProfile> createState() => _EditSalonProfileState();
}

class _EditSalonProfileState extends State<EditSalonProfile> {
  File? image;
  void takePicture() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  TextEditingController textEditingController = TextEditingController();
  Map<String, dynamic> salonData = {};
    String email="";
    String name="";
    String address="";
    String phone="";
    String cartNumber="";
    String pic="";
     // Initialisation des données du salon
Future<void > fetchUserData() async {
 try{ String salonId = FirebaseAuth.instance.currentUser!.uid;
print(salonId);
  DocumentSnapshot<Map<String, dynamic>> salonSnapshot =
      await FirebaseFirestore.instance.collection( widget.userType=="salons"?  "salons": "freelancers").doc(salonId).get();
      if(salonSnapshot.exists){setState(() {  
        email=salonSnapshot['email'];
        name=salonSnapshot['name'];
      //  address=salonSnapshot['address'];
       // phone=salonSnapshot['phone'];
        //cartNumber=salonSnapshot['cartNumber'];
        pic=salonSnapshot['image'][0];
         salonData = salonSnapshot.data()!;
         print(name);
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
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar:AppBar(
        title: Text( "Modifier le profil"),
        backgroundColor: BbRed,
      ),
            drawer: Menu(context,widget.userType),
      
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          image == null
              ? CupertinoButton(
                  onPressed: () {
                    takePicture();
                  },
                  child: const CircleAvatar(
                      radius: 55, child: Icon(Icons.camera_alt)),
                )
              : CupertinoButton(
                  onPressed: () {
                    takePicture();
                  },
                  child: CircleAvatar(
                    backgroundImage: FileImage(image!),
                    radius: 55,
                  ),
                ),
          const SizedBox(
            height: 12.0,
          ),
          TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: name,
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          ourButton(
            title: "Update",
            onPress: () async {
              //SalonModel salonModel = appProvider.getSalonInformation
                //  .copyWith(name: textEditingController.text);
                 String salonId = FirebaseAuth.instance.currentUser!.uid;
    final salonDoc = await FirebaseFirestore.instance.collection( widget.userType=="salons"?  "salons": "freelancers").doc(salonId).get();
  
      final salonData = salonDoc.data() as Map<String, dynamic>;

      // Créez un modèle de salon à partir des données récupérées
      final salonModel = SalonModel(
        // Assurez-vous d'adapter ces champs à votre modèle SalonModel
        name: salonData['name'],
        address: salonData['address'],
        image: salonData['image'],
        CartNumber: salonData['cartNumber'],
        email: salonData['email'],
        phone: salonData['phone'],
        isFavourite: false,
        id: salonData['id'],
        // Ajoutez d'autres champs si nécessaire
      );
    
              appProvider.updateSalonInfoFirebase(context, salonModel, image!);
            },
          ),
        ],
      ),
    );
  }
}
