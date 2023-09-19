import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_rim/account_screen/account_screens.dart';
import 'package:app_rim/constants/constants.dart';
import 'package:app_rim/widgets_common/our_button.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';
import '../firebase_helper/firebase_storage_helper/firebase_storage_helper.dart';
import '../models/user_model/user_model.dart';
import '../widgets_common/AppBar_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
    String pic="";
     // Initialisation des données du salon
Future<void > fetchUserData() async {
 try{ String userId = FirebaseAuth.instance.currentUser!.uid;
print(userId);
  DocumentSnapshot<Map<String, dynamic>> salonSnapshot =
      await FirebaseFirestore.instance.collection("users").doc(userId).get();
      if(salonSnapshot.exists){setState(() {  
        email=salonSnapshot['email'];
        name=salonSnapshot['name'];
     
        pic=salonSnapshot['image'];
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
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
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
      String userId = FirebaseAuth.instance.currentUser!.uid;
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection("users");

      Map<String, dynamic> updatedData = {
        "name": textEditingController.text,
        "image":await FirebaseStorageHelper.instance.uploadUserImage(image!)
      };
      await usersCollection.doc(userId).update(updatedData); 
      showMessage("Profil mis à jour avec succès!");   
        await Future.delayed(Duration(seconds: 1));
  
  Get.to(() =>  AccountScreen());        
      
    } catch (error) {
      print("Error updating user data: $error");
    }
  },
),

        ],
      ),
    );
  }
}
