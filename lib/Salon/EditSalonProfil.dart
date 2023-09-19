import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_rim/Salon/SalonProfil.dart';
import 'package:app_rim/widgets_common/our_button.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';
import '../Consts/colors.dart';
import '../constants/constants.dart';
import '../firebase_helper/firebase_storage_helper/firebase_storage_helper.dart';
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
            title: "Mettre à jour",
             onPress: () async {
              try {
                String salonId = FirebaseAuth.instance.currentUser!.uid;
                String imageUrl = await FirebaseStorageHelper.instance.uploadUserImage(image!);

                final salonDoc = await FirebaseFirestore.instance.collection(widget.userType == "salons" ? "salons" : "freelancers").doc(salonId).get();
                final salonData = salonDoc.data() as Map<String, dynamic>;

                salonData['image'][0] = imageUrl;
                salonData['name']=textEditingController.text;

                await salonDoc.reference.update(salonData);

                showMessage("Profil mis à jour avec succès!");
  await Future.delayed(Duration(seconds: 1));
  
  Get.to(() =>  SalonProfilScreen(userType: widget.userType,));
              } catch (error) {
                print("Erreur lors de la mise à jour du profil : $error");
              }
            },
          ),
        ],
      ),
    );
  }
}
